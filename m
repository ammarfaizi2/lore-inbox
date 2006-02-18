Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWBRVE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWBRVE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 16:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWBRVE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 16:04:27 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:26756 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S932161AbWBRVE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 16:04:27 -0500
Date: Sat, 18 Feb 2006 22:04:28 +0100
From: Martin Mares <mj@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, greg@kroah.com, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060218.210213.17059.albireo@ucw.cz>
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix> <43F1BE96.nailMY212M61V@burner> <87d5hpr2ct.fsf@hades.wkstn.nix> <43F46B91.nail20W817IPJ@burner> <mj+md-20060216.123601.20797.atrey@ucw.cz> <43F746B8.6080607@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F746B8.6080607@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> MO, WORM, {ZIP,ls120} drives if you are using the full capabilities, IDE 
> tape drives, etc.
> 
> Sorry, I don't remember what capability the ls120 was using, but as of 
> 2.6.12 it didn't work through the ide-floppy interface.

Then it's a bug in ide-floppy which should be fixed.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Immanuel doesn't pun, he Kant.
