Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280429AbRJaTNr>; Wed, 31 Oct 2001 14:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280430AbRJaTNi>; Wed, 31 Oct 2001 14:13:38 -0500
Received: from apollo.wizard.ca ([204.244.205.22]:18449 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S280429AbRJaTNZ>;
	Wed, 31 Oct 2001 14:13:25 -0500
Subject: Re: What is standing in the way of opening the 2.5 tree?
From: Michael Peddemors <michael@wizard.ca>
To: Sujal Shah <sshah@progress.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1004479166.31041.13.camel@pcsshah>
In-Reply-To: <Pine.LNX.4.30.0110301335230.9312-100000@methlab.23.org> 
	<1004479166.31041.13.camel@pcsshah>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 31 Oct 2001 11:18:47 -0800
Message-Id: <1004555927.11209.45.camel@mistress>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Full moon must be getting to me, I have to open my mouth, and howl my
opinion..

As a consultant, it seems a shame to open up a 2.5 UNTIL 2.4 is dead
stable.. When it comes to servers, I still have to recommend that my
clients stick to a 2.2 series..  Of course, I am subject to some deep
flames as well, but we defienlty aren't getting enough testing in the
-pre series each time..
So far, every 2.4.x release has followed with a series of OOPS, OOM
problems, last minite updates to the pre cycle that caused bugs..  The
2.4 series has changed So many fundamentals since 2.4.0 that it seems
more like it is still 2.3. under development.

Although a few vendors are supplying 2.4 kernels with relative success,
I cannot with good conscious say that my clients servers will be
bulletproof like the 2.2 series was..

(I say this as I just finished a work order for a new Oracle Server,
still on 2.2)

I am surely looking for the next in the 2.4 series, as it seems like we
are finally solidifying, but when I look at all of the reccomendations
for 'which 2.4' kernel to use, it is amazing at how many people are
recommending kernels or a -pre nature, or -ac - even -aa as the most
solid.. When I would expect to see everyone recommending a single
production Linus Kernel version.

Can we get a single 2.4 series kernel that has fully been tested before
moving on to even more fundamental changes?
> 
> To be honest, I think that any x.y.z kernel is "unstable."  As we move
> into a situation with an even larger installed base, I think you're
> going to see a third tier become more evident: a) unstable, b) stable,
> c) vendor supported.  Quite frankly, if I'm making recommendations to
> customers and clients for a linux installation, I typically recommend
> for them to go with a vendor supplied kernel and manage it through the
> vendor.
> 
> > Please read the FAQ at  http://www.tux.org/lkml/
-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
Wizard IT Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

