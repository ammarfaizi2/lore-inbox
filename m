Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbRFSM5Q>; Tue, 19 Jun 2001 08:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbRFSM5G>; Tue, 19 Jun 2001 08:57:06 -0400
Received: from m4.worldnet.net ([195.3.3.8]:42769 "EHLO m4.worldnet.net")
	by vger.kernel.org with ESMTP id <S262607AbRFSM4y>;
	Tue, 19 Jun 2001 08:56:54 -0400
To: linux-kernel@vger.kernel.org
Subject: Re:Scsi
Message-ID: <992955412.3b2f4c14ae854@m4.worldnet.net>
Date: Tue, 19 Jun 2001 14:56:52 +0200 (CEST)
From: Emmanuel Fuste <fuste@worldnet.fr>
Cc: dead2@circlestorm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same problem, but with a 2940U2W scsi board.
Never tried 2.4.0 but I tried old and new AIC driver with no succes
Both in UP, UP+APIC and SMP kernel (2.4.4-acx and 2.4.5+).
You have more luck than me: removing all other boards in my box
change nothing.
My motherboard is an old asus P/I-P65UP5/C-P55T2D (bi p5 233MMX 
430HX chipset)
Fortunately my old 2940UW still works flawlessly.

Emmanuel.
