import AccountService from '../service/account-service.js';
import TunnelService from '../service/tunnel-service.js';
import Logger from '../logger.js';

export default async () => {
    const accountService = new AccountService();
    if (!accountService.account?.account_id) {
        Logger.error("No account provided");
        return false;
    }

    const tunnelService = new TunnelService();
    const tunnelId = tunnelService.tunnelId;
    if (!tunnelService.tunnelId) {
        Logger.error("No tunnel provided");
        return false;
    }

    if (await tunnelService.disconnect(tunnelId) === true) {
        Logger.info(`Tunnel ${tunnelId} disconnected`);
    } else {
        Logger.error(`Could not disconnect tunnel ${tunnelId}`);
    }

    return true;
}