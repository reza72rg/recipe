"""
sample tests
"""
from django.test import SimpleTestCase
from app import cale

class CaleTests(SimpleTestCase):
    " Test the cale models."
    def test_add_numbers(self):
        """Test adding numbers together."""
        res =cale.add(5, 6)
        self.assertEquals(res, 12)