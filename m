Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWF2Qx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWF2Qx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWF2Qx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:53:57 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:23310 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1750964AbWF2Qx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:53:57 -0400
Date: Thu, 29 Jun 2006 12:52:49 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Attack of "the the"s in /arch
Message-Id: <20060629125249.4ad83383.laplam@rpi.edu>
In-Reply-To: <20060629100457.4ed45d7e@localhost>
References: <000001c69b31$64186160$fe01a8c0@cyberdogt42>
	<20060628213924.50f29a4a.rdunlap@xenotime.net>
	<20060629011651.1543b42b.laplam@rpi.edu>
	<20060628230305.c9eaf6a9.rdunlap@xenotime.net>
	<20060629024805.63f8054c.laplam@rpi.edu>
	<20060629100457.4ed45d7e@localhost>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 12:53:01 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 12:53:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 10:04:57 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> On Thu, 29 Jun 2006 02:48:05 -0400
> Matt LaPlante <laplam@rpi.edu> wrote:
> 
> > I'll CC: to Linus and hope for the best.
> 
> Since Linus receives a lot of mails the best option was to send it to
> "trivial@kernel.org":
> 
> Documentation/SubmittingPatches:
> -----
> For small patches you may want to CC the Trivial Patch Monkey
> trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
> patches. Trivial patches must qualify for one of the following rules:
>  Spelling fixes in documentation
>  Spelling fixes which could break grep(1).
>  Warning fixes (cluttering with useless warnings is bad)
> ...
> -----
> 
> :)
> 
> -- 
> 	Paolo Ornati
> 	Linux 2.6.17.1 on x86_64
> 

Thanks for the pointer, I will do this from now on.  I was reading the patch submission info at http://www.kernel.org/pub/linux/docs/lkml/, and it does not suggest this (it goes Maintainer> Linus | Alan Cox), so I did not know.  Maybe this address could be added either to maintainers or the lkml page?

-
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
laplam@rpi.edu

