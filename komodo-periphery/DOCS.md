# Komodo Periphery

![Komodo Logo](https://raw.githubusercontent.com/jon-hedgerows/ha-apps/refs/heads/main/komodo-periphery/icon-192x192.png)

**Komodo Periphery Agent**: connects your Home Assistant server to [Komodo](https://komo.do) for centralized infrastructure management, container deployment, and server monitoring. Note that only the outbound connection mode in periphery is supported - periphery initiates the connection to the Komodo server.

## Configuration

### Required

| Option           | Description                                                                      |
| ---------------- | -------------------------------------------------------------------------------- |
| **Core Address** | DNS name or IP address of your Komodo Core instance (e.g., `komodo.example.com`) |
| **Connect As**   | Server name used for registration in Komodo                                      |

**Protection Mode** must be disabled.

### Optional

| Option                          | Default   | Description                                                        |
| ------------------------------- | --------- | ------------------------------------------------------------------ |
| **Onboarding Key**              | _(empty)_ | Onboarding Key for initial connection. Required for initial setup. |
| **Disable Terminals**           | `false`   | Disable terminal/SSH access through Periphery                      |
| **Disable Container Terminals** | `false`   | Disable container exec/attach through Periphery                    |
| **Include Disk Mounts**         | `/`       | Comma-separated mount paths to include in disk reports             |
| **Exclude Disk Mounts**         | _(empty)_ | Comma-separated mount paths to exclude from disk reports           |
| **Log Level**                   | info      | Log level                                                          |

## Setup

1. Install a Komodo Core instance (see [Komodo docs](https://komo.do/docs/setup))
2. In the Komodo UI go to **Settings**, and create an **Onboarding** key.
3. Install this app in Home Assistant
4. Configure **Core Address** (your Komodo Core URL) and **Connect As** (server name)
5. Paste the **Onboarding Key** from step 2
6. Disable Protection mode to allow periphery access to the system
7. Start the app
8. Verify connection status is **OK** in Komodo UI
9. Optionally remove the Onboarding Key from the app configuration.

## Privileges

This app requires elevated privileges (**`TBD`**) to manage Docker containers and monitor system resources. This is necessary for Komodo Periphery to function as a server management agent.

After installation you must disable Protection mode.

## Unsupported system - Unsupported software

If you deploy workloads to your Home Assistant instance through Komodo you **_will_** get an unsupported system warning.

> [!WARNING]
> **Unsupported system - Unsupported software**
>
> System is unsupported because additional software outside the Home Assistant ecosystem has been detected.
> For troubleshooting information, select [Learn more](https://www.home-assistant.io/more-info/unsupported/software).

## Developer Notes

This app does not use s6 because s6 is not compatible with the host_pid option.
