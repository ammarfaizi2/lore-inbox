Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbRFGPwn>; Thu, 7 Jun 2001 11:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbRFGPwd>; Thu, 7 Jun 2001 11:52:33 -0400
Received: from www.wen-online.de ([212.223.88.39]:19473 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261771AbRFGPwX>;
	Thu, 7 Jun 2001 11:52:23 -0400
Date: Thu, 7 Jun 2001 17:51:58 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: watermodem <aquamodem@ameritech.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
 table
In-Reply-To: <3B1F9B5A.42BF726D@ameritech.net>
Message-ID: <Pine.LNX.4.33.0106071747460.463-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2001, watermodem wrote:

> "David S. Miller" wrote:
> >
> > George Bonser writes:
> >  > There is, of course, one basic problem with that argument. While you can say
> >  > (and probably rightly so) that such a change would not be included in Linus'
> >  > kernel, I think anyone is allowed to post a patch that might make it
> >  > possible to add protocols as modules. If anyone chooses to use it is each
> >  > individual's decision but you could not prevent ACME from creating a patch
> >  > that allows protocol modules as long as they distributed the patch. Also,  I
> >  > know that you are allowed to distribute proprietary modules in binary form
> >  > but are there any restrictions on what function these modules can perform?
> >  > I don't remember seeing any such restrictions.
> >
> > People can post whatever patches which do whatever, sure.
> > But this isn't what matters.
> >
> > What matters is the API under which a binary-only module may interface
> > to the kernel.  Linus specifies that only the module exports in his
> > tree fall into this API.
> >
> > As I stated in another email, the allowance of binary-only kernel
> > modules is a special exception to the licensing of the kernel made by
> > Linus.  The GPL by itself, does not allow this at all.
> >
> > Later,
> > David S. Miller
> > davem@redhat.com
>
> David,
>
>    What is your real problem with La Monte's Code.
>    I don't buy your more "blessed than thou" argument.
>    It is a typical response one normally sees in large
>    organizations from folk with "empires" to protect.
>    Coming from the "land of warring tribes" firm it is
>    a attitude I have seen often.  My response is take
>    a vacation, chill out and reassess.

What words would you like to put in his mouth to replace those he used?

	-Mike

