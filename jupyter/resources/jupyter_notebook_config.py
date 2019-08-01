import os

c.NotebookApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy':
        'frame-ancestors self %s' % os.getenv('FRAME_ANCESTORS', '')
    }
}
