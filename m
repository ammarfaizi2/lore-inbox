Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbRFGFeb>; Thu, 7 Jun 2001 01:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbRFGFeV>; Thu, 7 Jun 2001 01:34:21 -0400
Received: from beasley.gator.com ([63.197.87.202]:33540 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S262242AbRFGFeP>; Thu, 7 Jun 2001 01:34:15 -0400
From: "George Bonser" <george@gator.com>
To: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Date: Wed, 6 Jun 2001 22:37:35 -0700
Message-ID: <CHEKKPICCNOGICGMDODJMECLDEAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <15134.53268.965680.167845@pizda.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ben Greear writes:
>  > a modular TCP stack might be a really
>  > good option for making $$ though support fees...  If there is a
>  > need to keep certain (proprietary) code out of the kernel, let
>  > lawyers & public pressure do it, not overly broad technical
> restrictions.
>
> There is a legal restriction, basically "Linus and the copyright
> holders of the networking say no."
>
> Later,
> David S. Miller
> davem@redhat.com

There is, of course, one basic problem with that argument. While you can say
(and probably rightly so) that such a change would not be included in Linus'
kernel, I think anyone is allowed to post a patch that might make it
possible to add protocols as modules. If anyone chooses to use it is each
individual's decision but you could not prevent ACME from creating a patch
that allows protocol modules as long as they distributed the patch. Also,  I
know that you are allowed to distribute proprietary modules in binary form
but are there any restrictions on what function these modules can perform?
I don't remember seeing any such restrictions.

In short, while you can refuse to accept such patches or support any
problems arising from their use, I would think that ACME has the right to
patch the kernel to make such a thing possible if they want to and there is
nothing (as far as I know) that anyone can do about it as long as they make
those patches public.  So, ACME can say that to use ACME Super FooWare you
will need the ACME Super FooKernel with our FooModule that is distributed in
binary format. If you want to build the FooKernel, here is the patch but the
module is still binary.

