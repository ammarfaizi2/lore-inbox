Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271147AbRIEFQZ>; Wed, 5 Sep 2001 01:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271138AbRIEFQG>; Wed, 5 Sep 2001 01:16:06 -0400
Received: from mail.webmaster.com ([216.152.64.131]:42647 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271011AbRIEFP4>; Wed, 5 Sep 2001 01:15:56 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6 
Date: Tue, 4 Sep 2001 22:16:15 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMOEBEDLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <17870.999661846@kao2.melbourne.sgi.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 4 Sep 2001 20:30:42 -0700,
> "David Schwartz" <davids@webmaster.com> wrote:

> >That really doesn't make sense. Nothing changes in the
> >kernel or the module
> >based upon whether you have the source or not. What should
> >logically taint
> >the kernel are modules that weren't compiled for that exact
> >kernel version
> >or are otherwise mismatched.
>
> Bug reports when binary only modules have been loaded do not belong on
> l-k, they have to go to the supplier.  AC wants to identify bug reports
> that we can look at and ignore the ones that we cannot sensibly
> investigate.  Any proprietary module loaded, at any time, means that
> the bug report will almost certainly be ignored.

	Yes, but even if the module is GPL'd, the module could still cost $1,000
and you're not entitled to the source if you didn't buy the module. If what
you want is "source code is available to the general public", then that can
be true or false for both GPL'd and non-GPL'd modules.

	If you make it 'must have been compiled from source on this machine" then
you know that at least this person has access to the source. If you make it
"source code must be publically avialable" then you know developers have
access to the  source. But the answer to both of these can be "yes" or "no"
for both GPL'd and non-GPL'd modules.

	What do you really want? Code that.

	DS

