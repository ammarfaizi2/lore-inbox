Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWBQKsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWBQKsY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 05:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWBQKsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 05:48:24 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:60546 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1750780AbWBQKsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 05:48:23 -0500
Date: Fri, 17 Feb 2006 11:48:17 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060217.104401.6698.albireo@ucw.cz>
References: <43EB7BBA.nailIFG412CGY@burner> <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr> <43F1F196.nailMWZE1HZK5@burner> <200602141710.37869.dhazelton@enter.net> <43F4652F.nail20W57J1QB@burner> <20060216115204.GA8713@merlin.emma.line.org> <43F4BF26.nail2KA210T4X@burner> <20060216181422.GA18837@merlin.emma.line.org> <43F5A5A4.nail2VC61NOF6@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F5A5A4.nail2VC61NOF6@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Namespace split ATA/SCSI is unfixed in 2.01.01a06.
> 
> The namne space split is a Linux kernel bug

You are getting ridiculous. A bug against what? Against your wishes?

> > Bogus warnings about /dev/* are unfixed in said version.
> 
> Warnings related to Linux kernel bugs

Rubbish. The Linux bugs you have pointed to are in ide-scsi and opening
/dev/hd* directly is guaranteed to avoid them. The only warning which would
make sense would be if somebody USES ide-scsi, not if he avoids it.

> > Linux uname() detection code is broken since 2.6.10 because it assumes
> > fixed-width fields.
> 
> Warnings related to Linux kernel bugs

Stop parroting and read what you are replying to.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
My Wife Says I Never Listen, Or Something Like That...
