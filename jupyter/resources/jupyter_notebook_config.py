import os
import

c.NotebookApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy':
        'frame-ancestors self %os.environ['FRAME-ANCESTORS']'
    }
}
