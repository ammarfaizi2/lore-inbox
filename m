Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277544AbRJVFUf>; Mon, 22 Oct 2001 01:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJVFUZ>; Mon, 22 Oct 2001 01:20:25 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:15366 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S277652AbRJVFUK>;
	Mon, 22 Oct 2001 01:20:10 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100300b7f95baa5d5a@[192.168.239.101]>
In-Reply-To: <5.0.2.1.2.20011021150919.00a57a60@mail.jetstream.net>
In-Reply-To: <20011021220346.D19390@vega.digitel2002.hu>
 <5.0.2.1.2.20011021150919.00a57a60@mail.jetstream.net>
Date: Mon, 22 Oct 2001 06:17:33 +0100
To: Leo Spalteholz <bspalteh@jetstream.net>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: RE: The new X-Kernel !
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:14 pm -0700 21/10/2001, Leo Spalteholz wrote:
>>This side thread is funny, everyone here is thinking too much like a
>>developer :)
>>
>>Normal users really don't need to see the startup message spam on boot,
>>unless there is an error (at which point it should be able to present
>>the error to the user).  Any kind of of progress indicator' s really
>>more for feedback that the boot is proceeding ok.  The fact the boot
>>sequence isn't even interactive should also be a big hint that it isn't
>>really necessary (except for kernel and driver developers).
>
>
>I agree that for the normal user, plain messages are useless..   I 
>remember something in Mandrake (7.0?), what they did is print a 
>green [OK]  after every message and a red [ERROR] when something 
>failed..  This was great for a quick visual check..   As soon as you 
>see something red scroll past you know there's something wrong and 
>you can check it later..
>So this should really be left up to the distros..

That's been in there since at least Red Hat 6.0, and has spread to 
all the derivatives, including mkLinux, Mandrake, Yellow Dog et al. 
I agree, it's a great system, even though it only works once the 
System V scripts start going.  If the kernel could do something like 
that (maybe with a "pretty" argument via LILO, and a compile-time 
option), it'd make the boot sequence a little less forbidding to 
(l)users.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
