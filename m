Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316952AbSGCHQf>; Wed, 3 Jul 2002 03:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSGCHQe>; Wed, 3 Jul 2002 03:16:34 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:13481 "EHLO
	pimout2-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S316952AbSGCHQd>; Wed, 3 Jul 2002 03:16:33 -0400
Message-Id: <200207030718.g637I0L145202@pimout2-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [OKS] Kernel release management
Date: Tue, 2 Jul 2002 21:19:41 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020702110848.27954D-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020702110848.27954D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 July 2002 11:13 am, Bill Davidsen wrote:

> The maintainer can alway push really new stuff into 2.7, and Linus can
> always refuse to take a feature into 2.7 until something else is fixed in
> 2.6. Looking at how hard people are working to backport things from 2.5 to
> 2.4 I have faith that extra effort will be taken.

People using the systems in production are going to care about stability.  
People selling systems to people using them in production are going to care 
about the stable series.  This means most of the people who have day jobs 
working with Linux at places like Red Hat and IBM.

Look at the pressure to get stuff into 2.4 when it's already in 2.5.  Because 
2.4 is what people are actually using, and 2.5 is really just for os 
development and testing (and general playing with) at this point.

Looking at it another way, Kieth Owens writing kbuild 2.5 and pushing hard 
for its inclusion didn't stop other people from patching the endless series 
of bugs in the old one.  Even when Kieth at least considered this 
counterproductive.

Rob
