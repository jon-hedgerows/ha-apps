# Komodo Periphery

Komodo Periphery agent connects your Home Assistant server to [Komodo](https://komo.do) for centralized infrastructure management, container deployment, and server monitoring.

## Configuration

### Required

| Option           | Description                                                                      |
| ---------------- | -------------------------------------------------------------------------------- |
| **Core Address** | DNS name or IP address of your Komodo Core instance (e.g., `komodo.example.com`) |
| **Connect As**   | Server name used for registration in Komodo                                      |

### Optional

| Option                          | Default   | Description                                                                                              |
| ------------------------------- | --------- | -------------------------------------------------------------------------------------------------------- |
| **Onboarding Key**              | _(empty)_ | Key for initial connection. Create in Komodo UI under Server settings. Can be removed after first setup. |
| **Disable Terminals**           | `false`   | Disable terminal/SSH access through Periphery                                                            |
| **Disable Container Terminals** | `false`   | Disable container exec/attach through Periphery                                                          |
| **Include Disk Mounts**         | `/`       | Comma-separated mount paths to include in disk reports                                                   |
| **Exclude Disk Mounts**         | _(empty)_ | Comma-separated mount paths to exclude from disk reports                                                 |

## Periphery Connection Mode

Only outbound mode is supported, set the **Core Address** and **Connect As** options.

## Setup

1. Install a Komodo Core instance (see [Komodo docs](https://komo.do/docs/setup))
2. Create a **Server Onboarding Key** in the Komodo UI
3. Install this add-on in Home Assistant
4. Configure **Core Address** (your Komodo Core URL) and **Connect As** (server name)
5. Paste the **Onboarding Key** from step 2
6. Start the add-on
7. Verify connection status is **OK** in Komodo UI

## Privileges

This add-on requires elevated privileges (`full_access`, `host_pid`) to manage Docker containers and monitor system resources. This is necessary for Komodo Periphery to function as a server management agent.

## Unsupported system - Unsupported software

If you deploy workloads to your Home Assistant instance through Komodo you _will_ get a "Unsupported system - Unsupported software" warning.

> **Unsupported system - Unsupported software**
>
> System is unsupported because additional software outside the Home Assistant ecosystem has been detected.
> For troubleshooting information, select [Learn more](https://www.home-assistant.io/more-info/unsupported/software).
