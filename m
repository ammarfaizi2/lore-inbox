Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287199AbSACM1l>; Thu, 3 Jan 2002 07:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287204AbSACM1Z>; Thu, 3 Jan 2002 07:27:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1541 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287199AbSACM0H>; Thu, 3 Jan 2002 07:26:07 -0500
Subject: Re: kswapd etc hogging machine
To: art@lsr.nei.nih.gov (Art Hays)
Date: Thu, 3 Jan 2002 12:37:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201022214230.8413-100000@lsr-linux> from "Art Hays" at Jan 02, 2002 10:33:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16M77M-0008CQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Machine- 4 processor 700Mhz Dell with 4G Ram and 6G swap space running
> stock Redhat 7.2 distribution.  All disks are SCSI using ext2.

What I/O - megaraid ?

> I apologize if this is well known.  If there is a simple solution I would 
> appreciate even a terse pointer to it.  Thanks.

If you are running the 2.4.7 kernel from the distro make sure you get the
errata one
