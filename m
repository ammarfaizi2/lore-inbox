Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292622AbSBQAFN>; Sat, 16 Feb 2002 19:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292621AbSBQAFE>; Sat, 16 Feb 2002 19:05:04 -0500
Received: from femail44.sdc1.sfba.home.com ([24.254.60.38]:61362 "EHLO
	femail44.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S292622AbSBQAEq>; Sat, 16 Feb 2002 19:04:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Nicolas Pitre <nico@cam.org>, "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Disgusted with kbuild developers
Date: Sat, 16 Feb 2002 19:05:29 -0500
X-Mailer: KMail [version 1.3.1]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0202161055030.16872-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.44.0202161055030.16872-100000@xanadu.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020217000440.FTZN23150.femail44.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 February 2002 11:06 am, Nicolas Pitre wrote:

> Don't tell us that's not doable.  Do it and show us that you can do a
> perfect translation of CML1 into CML2 with all CML1 structural flaws.

"Hey, the new VM in 2.4.10 should have replicated the swap overload failure 
case in 2.4.9!  The first implementation should definitely melt down exactly 
the same way!  We need to artificially introduce all the flaws in the old 
one, just to prove it can be done!  Otherwise the new code is not 
interesting."

"To get people to try Linux on the desktop, first we need to make it 
blue-screen just like windows."

"It's unfair to compare laptops to desktops unless you first remove the 
battery from the laptop."

What the...?

Wouldn't it be nice if there was an implementation of CML2 that did 
everything CML1 did -EXCEPT- for the structural flaws?  Rather than a blind 
mindless drooling bug-for-bug clone that defeats the whole purpose of 
reimplementing the thing?

Your requirement seems to be based on the blind assumption that CML1 had 
nothing whatsoever wrong with it, and CML2 didn't need to be done in the 
first place.  If that's your argument, then say it directly.  (That might be 
a defendable position.  The one you just stated isn't.)

As for breaking CML2 so it's capable of producing a configuration that the 
rulebase says won't compile, the way CML1 can...  You do understand the 
difference between a procedural and a declarative language, right?

Rob
