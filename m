Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTHOQDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTHOQDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:03:22 -0400
Received: from chromatix.demon.co.uk ([80.177.102.173]:25314 "EHLO
	lithium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id S264030AbTHOQDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:03:10 -0400
Date: Fri, 15 Aug 2003 17:02:54 +0100
Subject: Re: agpgart failure on KT400
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: tlee5794@rushmore.com
From: Jonathan Morton <chromi@chromatix.demon.co.uk>
In-Reply-To: <200308150934.57207.tlee5794@rushmore.com>
Message-Id: <EDCE6765-CF39-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Yes, I could use 2.6-x and help test that, but like so many people, I
>>> need to have something reliable so I can get some work done.
>>
>> FWIW, I installed 2.6.0-test3 and it seems to work well.  After
>> grabbing a later version of the ATI drivers (which are needed for 2.6
>> compatibility), the AGP was set up correctly and I'm back in X.  I'm
>> not seeing any stability problems so far.
>
> How did you get the ATI drivers to build with the 2.6 kernel?
> I got all kinds of nasty errors when I tried them.  Are you
> using the Schneider drivers, which version?

Dunno what they're called, but I'm using Gentoo Linux, which has 
reached 4.3.0-3.2.0 in terms of ATI fglrx drivers.  The tarball can be 
downloaded from Gentoo mirrors, but apparently not from ATI themselves.

That version compiles and works with 2.6, although I'm seeing some 
unclean behaviour that really should be fixed.

I'm copying this to the list, because this is at least the second 
request I've had on this subject.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@chromatix.demon.co.uk
website:  http://www.chromatix.uklinux.net/
tagline:  The key to knowledge is not to rely on people to teach you it.

