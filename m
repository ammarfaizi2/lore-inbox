Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269546AbRHHVfc>; Wed, 8 Aug 2001 17:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269568AbRHHVfW>; Wed, 8 Aug 2001 17:35:22 -0400
Received: from umail.unify.com ([204.163.170.2]:23772 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S269546AbRHHVfN>;
	Wed, 8 Aug 2001 17:35:13 -0400
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C425@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Mark Hahn'" <hahn@physics.mcmaster.ca>, jury gerold <geroldj@grips.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Athlon/MSI mobo combo broken?
Date: Wed, 8 Aug 2001 14:35:07 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so far, the only plausible theory is that some individual factor(s)
> (MB, bios settings, power quality, dram quality, etc) causes 
> the instability that some people report.
 

Let me add my voice to the crowd. I have the same MSI K7T Turbo with an
Athlon TBird 900MHz and 256M of PC133 SDRAM, and kernel 2.4.6 runs
rock-stable on it. However, 2.4.7 hangs hard after a day or so of uptime -
no response to pings, can't switch from X to a virtual console, etc. Sysrq-B
will reboot, but other Sysrq-keys (like Sysrq-S or Sysrq-U) don't seem to
work. Unfortunately I am invariably in X when this happens so I don't get to
see ant OOPS text, and there is no OOPS information in the system log after
the reboot.

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Zathras is used to being beast of burden to other peoples needs. Very sad
life. Probably have very sad death, but at least there is symmetry.
