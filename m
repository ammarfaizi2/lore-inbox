Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312612AbSCVBm7>; Thu, 21 Mar 2002 20:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312613AbSCVBmt>; Thu, 21 Mar 2002 20:42:49 -0500
Received: from GS176.SP.CS.CMU.EDU ([128.2.198.136]:10124 "EHLO
	gs176.sp.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S312612AbSCVBmm>; Thu, 21 Mar 2002 20:42:42 -0500
Message-Id: <200203220143.g2M1hrY30834@gs176.sp.cs.cmu.edu>
To: Dave Zarzycki <dave@zarzycki.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot 
In-Reply-To: Your message of "Thu, 21 Mar 2002 16:47:10 PST."
             <Pine.LNX.4.44.0203211626410.3631-100000@tidus.zarzycki.org> 
Date: Thu, 21 Mar 2002 20:43:53 -0500
From: John Langford <jcl@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Disabling the ALI 15X3 driver avoids the problem for me. If I can find 
>some free time, I'm going to start adding printf()s to see where things 
>are hanging...

I haven't tried that combination of options yet.  I'll check tomorrow.

-John
