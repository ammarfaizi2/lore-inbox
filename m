Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290261AbSAXW4d>; Thu, 24 Jan 2002 17:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290454AbSAXW4Z>; Thu, 24 Jan 2002 17:56:25 -0500
Received: from zero.tech9.net ([209.61.188.187]:44561 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290261AbSAXWzC>;
	Thu, 24 Jan 2002 17:55:02 -0500
Subject: Re: RFC: booleans and the kernel
From: Robert Love <rml@tech9.net>
To: timothy.covell@ashavan.org
Cc: Xavier Bestel <xavier.bestel@free.fr>, Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200201242246.g0OMkML06890@home.ashavan.org.>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org>
	<200201242123.g0OLNAL06617@home.ashavan.org.> <1011911622.2631.6.camel@bip>
	 <200201242246.g0OMkML06890@home.ashavan.org.>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 17:59:52 -0500
Message-Id: <1011913193.810.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 17:47, Timothy Covell wrote:

> > gcc already warns you about such errors.
> >
> > 	Xav
> 
> That's funny, I compiled it with "gcc -Wall foo.c" and got no
> warnings.    Please show me what I'm doing wrong and how
> it's _my_ mistake and not the compilers.

Hm, I recall seeing something like:

warning: suggest parentheses around assignment used as truth value

from gcc ... yep, I still do.

	Robert Love

