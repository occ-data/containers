import os

c.NotebookApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy':
        'frame-ancestors self %os.environ['FRAME_ANCESTORS']'
    }
}
