Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWBUIdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWBUIdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWBUIdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:33:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16749 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161431AbWBUIdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:33:11 -0500
Date: Tue, 21 Feb 2006 09:32:44 +0100
From: Jens Axboe <axboe@suse.de>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, davidsen@tmr.com,
       nix@esperi.org.uk, mj@ucw.cz, linux-kernel@vger.kernel.org,
       chris@gnome-de.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060221083243.GL8852@suse.de>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <43F7257D.80400@tmr.com> <43F9E8C2.nail4ALB11DH3@burner> <200602201354.00595.dhazelton@enter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602201354.00595.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20 2006, D. Hazelton wrote:
> On Monday 20 February 2006 11:05, Joerg Schilling wrote:
> > Bill Davidsen <davidsen@tmr.com> wrote:
> > > >If you did ever try to write reliable code that has to deal with this
> > > > kind of oddities, you would understand that it is sometimes better to
> > > > wait and to inform related people about the problems they caused.
> > >
> > > This ground has been covered. And at least in the case of filtering
> > > commands, that had to be done quickly and you know it.
> >
> > We all know that filtering is not needeed to fix a bug. It could have been
> > implemented completely relaxed and without any time pressure as the bug
> > that needed fixing could have been fixed by just requiring a R/W FD to
> > allow SG_IO.
> 
> In one post you complain that SG_IO is unneeded on /dev/hd* and related 
> devices and in this one you say that it's all that would have been needed to 
> fix a bug!
> 
> Joerg, I think it's time you stop dodging questions, shifting blame and all 
> the tactics you've been using and admit that you just don't like Linux. After 
> all, every time you are asked to provide a technical basis for an argument 
> you have three main tactics - Dodge it entirely, misquote POSIX or say "But 
> Solaris does it this way".

Please stop CC'ing me on this pointless thread! Dunno who put me back,
but I have absolutely ZERO interesting in reading any of it anymore. I'd
rather get a root canal while listening to Michael Bolton and getting my
right leg sawed off.

-- 
Jens Axboe

