Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280875AbRKGTGg>; Wed, 7 Nov 2001 14:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280915AbRKGTG0>; Wed, 7 Nov 2001 14:06:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7174 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280875AbRKGTGO>; Wed, 7 Nov 2001 14:06:14 -0500
Subject: Re: ext3 vs resiserfs vs xfs
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Wed, 7 Nov 2001 19:12:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Nov 07, 2001 06:40:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161Y87-00052r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when coming back up it fscked (I didn't touch anything - didn't even notice 
> any 5 second thing but I wasn't looking at this screen) and it found two 
> lost inodes (I got two entries in lost and found). So it still needs to 
> fsck by the looks of it?

That sounds like you used your own kernel with it and had ext2 mounting
the root fs (remember its back compatible)

Alan
