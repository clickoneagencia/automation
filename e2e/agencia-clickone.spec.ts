import { test, expect } from '@playwright/test';

test('Renderizar Inicio', async ({ page }) => {
  await page.goto('https://agenciaclickone.com/');
  await expect(page.getByRole('heading', { name: 'Capta nuevas oportunidades' })).toBeVisible();
  await expect(page.locator('section').filter({ hasText: 'Capta nuevas oportunidades' }).getByRole('button')).toBeVisible();
  await expect(page.getByRole('heading', { name: 'Quiero una asesoría en' })).toBeVisible();
  await expect(page.locator('.joinchat__button__open')).toBeVisible();
});
