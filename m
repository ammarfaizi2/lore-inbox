Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTE3QcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbTE3QcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:32:19 -0400
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:53773 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S263792AbTE3QcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:32:13 -0400
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
Message-ID: <36696BAFD8467644ABA0050BE3589059125837@ausx2kmpc106.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: linux-kernel@vger.kernel.org
Subject: [announce] DKMS - added SuSE/UnitedLinux kernel support
Date: Fri, 30 May 2003 11:45:22 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12C955261254189-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DKMS (Dynamic Kernel Module Support) now contains module build
kernel-preparation support for SLES/United Linux type kernels.  This allows
you to properly build modules for these kernels using DKMS.  Many thanks to
Fred Treasure - fwtreas () us ! ibm ! com for assisting in this.

Also, as SLES uses a different mkinitrd command then the one found in RH, if
REMAKE_INITRD is set in your dkms.conf, it does not remake the initrd for
you and instead tells you that you will have to do this manually.  If anyone
would like to send me feedback on best practices for SLES/UL initrd stuffs
so that this process can be automated, your help would be greatly
appreciated.

DKMS is at: http://www.lerhaupt.com/dkms/
Changeblog: http://www.lerhaupt.com/dkms/dkms.html

Thanks.

Gary Lerhaupt
Linux Development
Dell Computer Corporation

