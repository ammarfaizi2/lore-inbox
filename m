Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUAVOO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 09:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAVOO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 09:14:56 -0500
Received: from mail.convergence.de ([212.84.236.4]:19591 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264527AbUAVOOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 09:14:53 -0500
Date: Thu, 22 Jan 2004 15:14:48 +0100
From: Johannes Stezenbach <js@convergence.de>
To: mocm@mocm.de
Cc: Linus Torvalds <torvalds@osdl.org>, Zan Lynx <zlynx@acm.org>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: List 'linux-dvb' closed to public posts
Message-ID: <20040122141448.GB1103@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>, mocm@mocm.de,
	Linus Torvalds <torvalds@osdl.org>, Zan Lynx <zlynx@acm.org>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ecartis-01212004203954.14209.1@mail.convergence2.de> <20040121194315.GE9327@redhat.com> <Pine.LNX.4.58.0401211155300.2123@home.osdl.org> <1074717499.18964.9.camel@localhost.localdomain> <Pine.LNX.4.58.0401211413100.2123@home.osdl.org> <16399.1205.643528.19928@sheridan.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16399.1205.643528.19928@sheridan.metzler>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Metzler wrote:
> Linus Torvalds writes:
>  > 
>  > Bug reports should be more important to the recipient than to the sender. 
>  > Anything you do to make it more of a bother is WRONG. 
> 
> That's true. And being on the linux-dvb list I can't see why they
> would want to give it as a maintainer address. 
> AFAIR, recently there was only one guy from convergence sending in
> patches for the kernel anyway.

Someone has to do the job, and IMHO Michael does it very well.
Why do you think it would be a good idea if every patch would
be submitted by a differnt person?

> But maybe they have some problems
> within the company so they don't want to name one single person as a 
> maintainer.

There isn't a single maintainer. The different drivers in linuxtv.org
CVS are maintained by different people.

> Still they could give some joint mailing address. I don't think it is
> necessary to discuss all patches on the list, especially since those
> coming from people that are not on the list will probably be quite
> trivial or more kernel related than DVB hardware related.

I beg to differ. IMHO patches sent to the list from anyone are
invaluable input, especially (but not only) if they solve
actual bugs.

Anyway, the *only* reason why the linux-dvb list is closed is
the fear of spam. We are currently discussing whether to open
linux-dvb or create a second, open list for patch submission
only. It depends on the ability of the list admins to configure
effective spam filters.


Johannes
