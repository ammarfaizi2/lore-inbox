Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280029AbRKNCd6>; Tue, 13 Nov 2001 21:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280027AbRKNCdi>; Tue, 13 Nov 2001 21:33:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25485 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280017AbRKNCd2>;
	Tue, 13 Nov 2001 21:33:28 -0500
Date: Tue, 13 Nov 2001 18:32:56 -0800 (PST)
Message-Id: <20011113.183256.15406047.davem@redhat.com>
To: hiryuu@envisiongames.net
Cc: calin@ajvar.org, nitrax@giron.wox.org, linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200111132137.fADLbdW01289@demai05.mw.mediaone.net>
In-Reply-To: <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu>
	<200111132137.fADLbdW01289@demai05.mw.mediaone.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brian <hiryuu@envisiongames.net>
   Date: Tue, 13 Nov 2001 16:37:28 -0500

   We've tried a number of boards for our application servers and the only UP 
   AMD DDR board I trust right now is the Gigabyte GA-7DX.  They are rock 
   solid.
   
Try to use the AGP slot with a Radeon of GeForce card, do something
as simple as playing some quake with com_maxfps > 85 and the machine
will hang solidly.
