Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133099AbRDZFEo>; Thu, 26 Apr 2001 01:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133108AbRDZFEe>; Thu, 26 Apr 2001 01:04:34 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:27017
	"EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
	with ESMTP id <S133099AbRDZFE2>; Thu, 26 Apr 2001 01:04:28 -0400
Message-Id: <200104260504.OAA16871@toa006>
Date: Thu, 26 Apr 2001 14:04:23 +0900 (JST)
From: Tore Johansson <nrjtore@toa006.nrj.ericsson.se>
Reply-To: Tore Johansson <nrjtore@toa006.nrj.ericsson.se>
Subject: Tiny little problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: eRR9jIqWbSWkSCMWHICetw==
X-Mailer: dtmail 1.2.1 CDE Version 1.2.1 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with accessing a magneto opto drive in Linux.
Since I upgraded the kernel from 2.3 to 2.4 I can mount the MO
drive but if I try to access a file on the drive the kernel oopses...

After the kernel oops the MO can't be unmounted.

The MO is has a SCSI-2 interface and the SCSI interface is a Symbios
NCR8xx type.

Any ideas??

Cheers,
/Tore

