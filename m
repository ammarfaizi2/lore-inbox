Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266914AbRGHQk6>; Sun, 8 Jul 2001 12:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266915AbRGHQks>; Sun, 8 Jul 2001 12:40:48 -0400
Received: from [194.213.32.142] ([194.213.32.142]:5124 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266914AbRGHQkk>;
	Sun, 8 Jul 2001 12:40:40 -0400
Date: Sat, 30 Jun 2001 14:47:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Brad Pepers <brad@linuxcanada.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: For comment: draft BIOS use document for the kernel
Message-ID: <20010630144733.C255@toy.ucw.cz>
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu> <01062211113100.01758@dragon.linuxcan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01062211113100.01758@dragon.linuxcan.com>; from brad@linuxcanada.com on Fri, Jun 22, 2001 at 11:11:31AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > 1.3	Type 'apm -s'
> > 	The machine should standby
> >
> > 1.4	Wake it and type 'apm -S'
> > 	The machine should suspend
> 
> According to the man pages, "apm -s" does a suspend and "apm -S" does a 
> standby.

No, original seems good.

apm -s: suspend to ram
apm -S: suspend to disk

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

