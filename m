Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283432AbRLINSH>; Sun, 9 Dec 2001 08:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283433AbRLINRu>; Sun, 9 Dec 2001 08:17:50 -0500
Received: from a212-113-174-249.netcabo.pt ([212.113.174.249]:20005 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S283432AbRLINRh>;
	Sun, 9 Dec 2001 08:17:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: SCSI????
Date: Sun, 9 Dec 2001 13:18:26 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0112081748080.5506-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0112081748080.5506-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01dY6hlHK0000d851@smtp.netcabo.pt>
X-OriginalArrivalTime: 09 Dec 2001 13:16:32.0818 (UTC) FILETIME=[B8A18920:01C180B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i can show u my boot log... but u aren't after the deamons who start are u 
????

the first part of the boot is so fast i cant read it, i know usb mass storage 
loads or something like that because i can see something related to that, 
beside of that i can't read the messages becaus htey prompt out too fast!!!

and i can't find a log file for those either!!!

anyway here is my boot log:


Dec  9 12:57:50 AstinusGod syslog: syslogd startup succeeded
Dec  9 12:57:50 AstinusGod syslog: klogd startup succeeded
Dec  9 12:57:50 AstinusGod portmap: portmap startup succeeded
Dec  9 12:57:50 AstinusGod nfslock: rpc.statd startup succeeded
Dec  9 12:57:51 AstinusGod keytable: Loading keymap:  succeeded
Dec  9 12:57:51 AstinusGod keytable: Loading system font:  succeeded
Dec  9 12:57:51 AstinusGod random: Initializing random number generator:  
succeeded
Dec  9 12:57:51 AstinusGod netfs: Mounting other filesystems:  succeeded
Dec  9 12:57:52 AstinusGod apmd: apmd startup succeeded
Dec  9 12:57:39 AstinusGod rc.sysinit: Mounting proc filesystem:  succeeded 
Dec  9 12:57:39 AstinusGod rc.sysinit: Unmounting initrd:  succeeded 
Dec  9 12:57:39 AstinusGod sysctl: net.ipv4.ip_forward = 0 
Dec  9 12:57:39 AstinusGod sysctl: net.ipv4.conf.default.rp_filter = 1 
Dec  9 12:57:39 AstinusGod sysctl: kernel.sysrq = 0 
Dec  9 12:57:39 AstinusGod rc.sysinit: Configuring kernel parameters:  
succeeded 
Dec  9 12:57:39 AstinusGod date: Sun Dec  9 12:57:33 WET 2001 
Dec  9 12:57:39 AstinusGod rc.sysinit: Setting clock  (localtime): Sun Dec  9 
12:57:33 WET 2001 succeeded 
Dec  9 12:57:39 AstinusGod rc.sysinit: Loading default keymap succeeded 
Dec  9 12:57:39 AstinusGod rc.sysinit: Setting default font (lat0-sun16):  
succeeded 
Dec  9 12:57:39 AstinusGod rc.sysinit: Activating swap partitions:  succeeded 
Dec  9 12:57:39 AstinusGod rc.sysinit: Setting hostname AstinusGod.pt:  
succeeded 
Dec  9 12:57:39 AstinusGod fsck: /: clean, 192863/1281696 files, 
830434/2562367 blocks 
Dec  9 12:57:39 AstinusGod rc.sysinit: Checking root filesystem succeeded 
Dec  9 12:57:39 AstinusGod rc.sysinit: Remounting root filesystem in 
read-write mode:  succeeded 
Dec  9 12:57:41 AstinusGod rc.sysinit: Finding module dependencies:  
succeeded 
Dec  9 12:57:42 AstinusGod fsck: /home: clean, 19308/499968 files, 
125323/998384 blocks 
Dec  9 12:57:42 AstinusGod rc.sysinit: Checking filesystems succeeded 
Dec  9 12:57:42 AstinusGod rc.sysinit: Mounting local filesystems:  succeeded 
Dec  9 12:57:42 AstinusGod rc.sysinit: Enabling local filesystem quotas:  
succeeded 
Dec  9 12:57:43 AstinusGod rc.sysinit: Turning on process accounting 
succeeded 
Dec  9 12:57:52 AstinusGod autofs: automount startup succeeded
Dec  9 12:57:44 AstinusGod rc.sysinit: Enabling swap space:  succeeded 
Dec  9 12:57:46 AstinusGod ipchains: Flushing all current rules and user 
defined chains: succeeded 
Dec  9 12:57:46 AstinusGod ipchains: Clearing all current rules and user 
defined chains: succeeded 
Dec  9 12:57:47 AstinusGod ipchains: Applying ipchains firewall rules 
succeeded 
Dec  9 12:57:47 AstinusGod sysctl: net.ipv4.ip_forward = 0 
Dec  9 12:57:47 AstinusGod sysctl: net.ipv4.conf.default.rp_filter = 1 
Dec  9 12:57:47 AstinusGod sysctl: kernel.sysrq = 0 
Dec  9 12:57:52 AstinusGod rc: Starting pcmcia:  succeeded
Dec  9 12:57:47 AstinusGod network: Setting network parameters:  succeeded 
Dec  9 12:57:48 AstinusGod network: Bringing up interface lo:  succeeded 
Dec  9 12:57:49 AstinusGod ifup: Determining IP information for eth0... 
Dec  9 12:57:49 AstinusGod ifup:  done. 
Dec  9 12:57:49 AstinusGod network: Bringing up interface eth0:  succeeded 
Dec  9 12:57:52 AstinusGod sshd: Starting sshd:
Dec  9 12:57:53 AstinusGod sshd:  succeeded
Dec  9 12:57:53 AstinusGod sshd: 
Dec  9 12:57:53 AstinusGod rc: Starting sshd:  succeeded
Dec  9 12:57:56 AstinusGod xinetd: xinetd startup succeeded
Dec  9 12:57:58 AstinusGod lpd: lpd startup succeeded
Dec  9 12:57:59 AstinusGod sendmail: sendmail startup succeeded
Dec  9 12:58:00 AstinusGod gpm: gpm startup succeeded
Dec  9 12:58:00 AstinusGod crond: crond startup succeeded
Dec  9 12:58:02 AstinusGod xfs: xfs startup succeeded
Dec  9 12:58:03 AstinusGod smb: smbd startup succeeded
Dec  9 12:58:03 AstinusGod smb: nmbd startup succeeded
Dec  9 12:58:03 AstinusGod anacron: anacron startup succeeded
Dec  9 12:58:03 AstinusGod atd: atd startup succeeded
Dec  9 12:58:04 AstinusGod linuxconf: Running Linuxconf hooks:  succeeded
Dec  9 12:58:04 AstinusGod rc: Starting wine:  succeeded
 there are no connected devices in /proc/scsi/scsi ( as they should for what 
i know hp82xxx is treated as a scsi device under linux red hat 7.2 )
and i can't find no /proc/usb directory

regards, AStinus

On Saturday 08 December 2001 22:49, you wrote:
> > whenever linux boots it trys to load the Scsi modules for the new kernel
> > but it [ fails ], i figure this is because my previous had scsi as module
> > and now it isn't a module but a integrated part of the kernel, so i
> > turned off  the scsi from the service manager. ( don't know if i am right
> > though ).
>
> exactly.  in other words, entirely a user-space issue,
> nothing to do with linux-kernel.
>
> > second, how do i make sure scsi support is actually running???
>
> /proc/devices?  dmesg?
>
> > third, if scsi is running and if i have the usb mass storage built into
> > the kernel, why doesn't my cd-rw appear listed  as a scsi connected
> > device as it should??
>
> what usb and scsi-related messages do you see on boot?
