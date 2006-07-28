Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbWG1OBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWG1OBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWG1OBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:01:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7697 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1161162AbWG1OBL (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:01:11 -0400
Date: Fri, 28 Jul 2006 14:01:00 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060728140059.GD4623@ucw.cz>
References: <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org> <20060724113534.GA64920@dspnet.fr.eu.org> <20060724133939.GA11353@thunk.org> <20060724153853.GA88678@dspnet.fr.eu.org> <20060726130806.GA5270@ucw.cz> <20060727155222.GA30593@dspnet.fr.eu.org> <20060727214224.GB3797@elf.ucw.cz> <20060727232249.GA25993@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727232249.GA25993@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-07-06 01:22:49, Olivier Galibert wrote:
> On Thu, Jul 27, 2006 at 11:42:25PM +0200, Pavel Machek wrote:
> > So we have 1 submission for review in 11/2004 and 1 submission for -mm
> > merge in 2006, right?
> 
> Wrong.  I gave a list of dates at the beginning of the month, do you
> think I threw dice to get them?
> 
> And could you explain, as suspend maintainer for the linux kernel, how
> come code submitted for the first time two years ago and with a much
> better track record than the in-kernel one is still not in?

Because Nigel has too much of code to start with, and refuses to fix
his design because it would invalidate all the stabilization work.

Plus Nigel did not do very good job with submitting those patches.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
