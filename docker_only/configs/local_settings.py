## Graphite local_settings.py
# Edit this file to customize the default Graphite webapp settings
#
# Additional customizations to Django settings can be added to this file as well
# For a more detailed local_settings.py template file, go to:
# https://github.com/graphite-project/graphite-web/blob/master/webapp/graphite/local_settings.py.example

#####################################
# General Configuration #
#####################################
# Set this to a long, random unique string to use as a secret key for this
# install. This key is used for salting of hashes used in auth tokens,
# CRSF middleware, cookie storage, etc. This should be set identically among
# instances if used behind a load balancer.

try:
    from graphite.local_auth import ENDPOINT_SECRET_KEY
except ImportError:
    ENDPOINT_SECRET_KEY = 'UNSECURED_ENDPOINT'

# Set your local timezone (Django's default is America/Chicago)
# If your graphs appear to be offset by a couple hours then this probably
# needs to be explicitly set to your local timezone.
TIME_ZONE = 'UTC'

# Override this to provide documentation specific to your Graphite deployment
#DOCUMENTATION_URL = "http://graphite.readthedocs.org/"

# Enable full debug page display on exceptions (Internal Server Error pages)
DEBUG = True


#####################################
# Additional Django Settings #
#####################################
# Uncomment the following line for direct access to Django settings such as
# MIDDLEWARE_CLASSES or APPS
from graphite.app_settings import *


class SecretKeyMiddleware(object):
    def process_request(self, request):
        if (ENDPOINT_SECRET_KEY == 'UNSECURED_ENDPOINT'
                or request.GET.get('secret') == ENDPOINT_SECRET_KEY
                or request.POST.get('secret') == ENDPOINT_SECRET_KEY):
            return None

        from django.http import HttpResponse
        response = HttpResponse('<h1>403 Forbidden</h1>')
        response.status_code = 403
        return response


MIDDLEWARE_CLASSES += ('graphite.local_settings.SecretKeyMiddleware',)
