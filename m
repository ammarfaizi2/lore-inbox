Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264327AbRFHV3e>; Fri, 8 Jun 2001 17:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264347AbRFHV3Y>; Fri, 8 Jun 2001 17:29:24 -0400
Received: from ibis.worldnet.net ([195.3.3.14]:30219 "EHLO ibis.worldnet.net")
	by vger.kernel.org with ESMTP id <S264327AbRFHV3K> convert rfc822-to-8bit;
	Fri, 8 Jun 2001 17:29:10 -0400
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Fri, 08 Jun 2001 23:28:25 +0200
Subject: Re: temperature standard - global config option?
From: Chris Boot <bootc@worldnet.fr>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Michael H. Warfield" <mhw@wittsend.com>
CC: mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
        "L. K." <lk@aniela.eu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <B7471019.F9CF%bootc@worldnet.fr>
In-Reply-To: <200106082116.f58LGd2497562@saturn.cs.uml.edu>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Only the truly stupid would assume accuracy from decimal places.

Well then, tell all the teachers in this world that they're stupid, and tell
everyone who learnt from them as well.  I'm in high school (gd. 11, junior)
and my physics teacher is always screaming at us for putting too many
decimal places or having them inconsistent.  There are certain situations
where adding a ±1 is too cumbersome and / or clumsy, so you can specify the
accuracy using just decimal places.

For example, 5.00 would mean pretty much spot on 5 (anywhere from 4.995 to
5.00499), wheras 5 could mean anywhere from 4.5 to 5.499.

Please, let's quit this dumb argument.  We all know that thermistors and
other types of cheap temperature gauges are very inaccurate, and I don't
think expensive thermocouples will make it into computer sensors very soon.
Plus, who the hell could care whether their chip is at 45.4 or 45.5 degrees?
Does it really matter?  A difference of 0.1 will not decide whether your
chip will fry.

Just my 2 eurocents.

-- 
Chris Boot
bootc@worldnet.fr

DOS Computers manufactured by companies such as IBM, Compaq, Tandy, and
millions of others are by far the most popular, with about 70 million
machines in use worldwide. Macintosh fans, on the other hand, may note
that cockroaches are far more numerous than humans, and that numbers
alone do not denote a higher life form.
New York Times, November 26, 1991

