Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264918AbRFULTV>; Thu, 21 Jun 2001 07:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbRFULTK>; Thu, 21 Jun 2001 07:19:10 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:1775 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S264918AbRFULSu> convert rfc822-to-8bit; Thu, 21 Jun 2001 07:18:50 -0400
Mime-Version: 1.0
Message-Id: <a05101002b75785e5b3fc@[192.168.239.105]>
In-Reply-To: <83JR8lhmw-B@khms.westfalen.de>
In-Reply-To: <200106082116.f58LGd2497562@saturn.cs.uml.edu>
 <B7471019.F9CF%bootc@worldnet.fr> <83JR8lhmw-B@khms.westfalen.de>
Date: Thu, 21 Jun 2001 12:18:12 +0100
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: temperature standard - global config option?
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > Only the truly stupid would assume accuracy from decimal places.
>>
>>  Well then, tell all the teachers in this world that they're stupid, and tell
>>  everyone who learnt from them as well.
>
>*All*?
>
>>  I'm in high school (gd. 11, junior)
>>  and my physics teacher is always screaming at us for putting too many
>>  decimal places or having them inconsistent.
>
>Ok, *yours*.
>
>But yours is not all. I certainly don't remember ever seeing that attitude 
>in school.
>
>And yes, this behaviour *is* stupid. Someone who thinks like that should
>never be allowed to become a science teacher.

*cough*

I've been taught by every Maths, Engineering and Physics 
teacher/lecturer I've encountered to write down significant figures 
consistent with the precision of the value.  So blindly writing down 
a value of 59.42886726469 ±2°C is obviously ludicrous, even if that's 
what my calculator gives me.  I should instead write 59 ±2°C, since 
that is the most precision I can possibly know it to.  With some 
advanced measuring techniques it *may* be acceptable to write 59.43 
±2°C *at most*, and then only if you really know why you need the 
extra information.

The UK education system is one of the better ones available, and the 
above philosophy is consistently held throughout it.  I'd be well 
advised not to argue, especially since it's common sense.
-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
