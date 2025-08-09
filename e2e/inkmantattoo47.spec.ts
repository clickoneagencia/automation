import { test, expect } from '@playwright/test';

test('Renderizar Inicio', async ({ page }) => {
  await page.goto('https://inkmantattoo47.com/');
  await expect(page.getByRole('banner').locator('img')).toBeVisible();
  await expect(page.locator('.joinchat__button__open')).toBeVisible();
  await expect(page.getByRole('link', { name: 'Cotiza aquí' })).toBeVisible();
});
