Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUHGLTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUHGLTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 07:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUHGLTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 07:19:39 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:24705 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261405AbUHGLTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 07:19:37 -0400
Date: Sat, 7 Aug 2004 13:19:33 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040807111933.GA4863@ucw.cz>
References: <200408071053.i77Aromi006941@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408071053.i77Aromi006941@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Well, so could you please enlighten the Linux people and say in a couple
> >of words how it could be done?
> 
> 1)	Fetch the Solaris install CD images from:
> 	http://wwws.sun.com/software/solaris/solaris-express/get.html

Grrr!  I wanted you to describe the solution, not how to install Solaris!

You continue asserting that there is some solution to the device numbering
problem (although most other people believe that the problem is unsolvable)
and when asked for the solution, you keep pointing in random directions.

So either show a proof (and shouting that some random OS and that everybody
else should install to find out, is not a proof), or shut up and admit
that you are wrong.

Also, you still forget to state any valid reason why SCSI-like devices should
be referred to in a way different from all other devices, which traditionally
use names of special files.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Nothing is smiple enough to be not screwed up.
