Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293536AbSCGHXG>; Thu, 7 Mar 2002 02:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293539AbSCGHWz>; Thu, 7 Mar 2002 02:22:55 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:64143
	"HELO tabris.net") by vger.kernel.org with SMTP id <S293538AbSCGHWk>;
	Thu, 7 Mar 2002 02:22:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <adam@tabris.net>
Organization: Dome-S-Isle Data
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbols 2.4.18-pre9-mjc2
Date: Thu, 7 Mar 2002 02:22:32 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020307072233.D19A5FB913@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been a bit busy lately, but after the power went off last night, I 
decided to finish my compile of the latest (afaict) mjc kernel.

Already commented out a function (it was several days ago, I can't 
remember it.) that was obsoleted by the radix tree patch. Now, I come up 
w/ this error in modules_install .

Ideas?

depmod: *** Unresolved symbols in 
/lib/modules/2.4.18-pre9-mjc2/kernel/drivers/scsi/sd_mod.o
depmod: 	blkdev_varyio

TIA
--
tabris
