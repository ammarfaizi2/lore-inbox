Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRC3PLq>; Fri, 30 Mar 2001 10:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRC3PL0>; Fri, 30 Mar 2001 10:11:26 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:13577 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131480AbRC3PLS>; Fri, 30 Mar 2001 10:11:18 -0500
Message-Id: <200103301509.f2UF9ws23721@aslan.scsiguy.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: George Bonser <george@gator.com>, linux-kernel@vger.kernel.org,
   Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.3 aic7xxx wont compile 
In-Reply-To: Your message of "Fri, 30 Mar 2001 12:05:01 +0300."
             <20010330120501.P23336@mea-ext.zmailer.org> 
Date: Fri, 30 Mar 2001 08:09:58 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Yes,  "-I." from gcc flags.
>
>  The sad part is that people have been patching right and left to get
>  that monster utility to compile because the dependencies say that it
>  must be used to remake the AIC sequencer binary image; which image is
>  perfectly ok except of its timestampts due to patching process.

The sad part is that there has been a fix for this "problem", supplied
by the author of the driver, for well over a month that everyone seems
to ignore.

--
Justin
