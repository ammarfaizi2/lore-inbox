Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUFRLGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUFRLGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUFRLGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:06:04 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:65319 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265102AbUFRLF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:05:59 -0400
Subject: Re: Stop the Linux kernel madness
From: Redeeman <lkml@metanurb.dk>
To: 4Front Technologies <dev@opensound.com>
Cc: Bastiaan Spandaw <lkml@becobaf.com>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <40D24963.7040003@opensound.com>
References: <40D232AD.4020708@opensound.com>
	 <77709e76040617180749cd1f09@mail.gmail.com>
	 <40D24163.5000006@opensound.com> <1087522622.5475.30.camel@louise3.6s.nl>
	 <40D24963.7040003@opensound.com>
Content-Type: text/plain
Message-Id: <1087556755.9980.14.camel@redeeman.kaspersandberg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 13:05:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 03:46, 4Front Technologies wrote:
> Content-Transfer-Encoding: 7bit
> Sender:	linux-kernel-owner@vger.kernel.org
> Precedence: bulk
> X-Mailing-List:	linux-kernel@vger.kernel.org
> 
> Bastiaan Spandaw wrote:
> > 
> > The distributions you named earlier all patch the kernels they ship with
> > their distribution.
> > 
> > There's only a handfull that install a vanilla kernel by default (out of
> > the >200 distributions available)
> > 
> > debian, redhat & gentoo patch their kernels.
> > 
> > 
> > Is your problem that a kernel is not the kernel.org vanilla version? (If
> > so have a fit @ debian, redhat and gentoo as well )
> > 
> 
> Redhat/Debian/Gentoo do the right thing by the kernel from www.kernel.org.
the right thing = compatible with your drivers.
> 
> > Or that Suse's does not work with your income generating product?
> > 
> We can fix our problems. It's just that it's becomming a treadmill.
> What's with you guys?. Would you really like to see Linux forking?
who says all the modifications suse does to their kernel is on the bad
side? im sure they some kind of reason to change the kernel code.
true, its not exactly the same as the vanilla kernel.
and true, it would be best if they could make do compatible code,
however, and as you are supposed to be a developer, you must know that
it is not possible to always keep compatibility.
and as earlier mentioned, "it has 11mb differences."
oh well well, the unzipped suse diff from you, is 13mb, but that doesent
really matter, however, what matters is all the overhead diff creates.
if you open the diff you can see that it will probably only be half the
differences the suse kernel really has, like 6.5mb or something near it.

i dont want to say theres no possibility that there really is a kernel
bug. but saying "madness" is abit harsh to do.

> 
> 
> 
> 
> best regards
> 
> Dev Mazumdar
> ---------------------------------------------------------------------
> 4Front Technologies
> 4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
> Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
> ---------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Regards, Redeeman
redeeman@metanurb.dk

