Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285098AbRLLIs1>; Wed, 12 Dec 2001 03:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285099AbRLLIsS>; Wed, 12 Dec 2001 03:48:18 -0500
Received: from 210-86-49-187.jetstart.xtra.co.nz ([210.86.49.187]:2176 "EHLO
	albatross.hisdad.org.nz") by vger.kernel.org with ESMTP
	id <S285098AbRLLIr7>; Wed, 12 Dec 2001 03:47:59 -0500
Subject: [2.4.16 bug] Major failure
From: John Huttley <john@mwk.co.nz>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: acpi-devel@sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Dec 2001 21:47:46 +1300
Message-Id: <1008146872.1458.1.camel@albatross.hisdad.org.nz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reprise; This is a system with a TNT2 video card,scsi and 2 cpus.
It locks up with acpi on, when switching vc's.(as described on lkml)

I have now established that no problem occurs when compiled as UP system.
This is true if acpi is modules or compiled in.


Trying a different compiler isn't feasible for me.


Any other ideas?

Regards

John



