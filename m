Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVHPJrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVHPJrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVHPJrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:47:10 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:13211 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965172AbVHPJrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:47:09 -0400
Date: Tue, 16 Aug 2005 11:46:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
cc: Lee Revell <rlrevell@joe-job.com>,
       Stephen Pollei <stephen.pollei@gmail.com>,
       Martin =?iso-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
In-Reply-To: <20050813184951.GA8283@carfax.org.uk>
Message-ID: <Pine.LNX.4.61.0508161145560.32120@yvahk01.tjqt.qr>
References: <42FDE286.40707@v.loewis.de> <feed8cdd0508130935622387db@mail.gmail.com>
 <1123958572.11295.7.camel@mindpipe> <20050813184951.GA8283@carfax.org.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1352548545-1124185618=:32120"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1352548545-1124185618=:32120
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>> > Thats great for the perl6 people.
>> > http://dev.perl.org/perl6/doc/design/syn/S03.html says they are going
>> > to be using « and » as operators...
>> 
>> Is Larry smoking crack?  That's one of the worst ideas I've heard in a
>> long time.  There's no easy way to enter those at the keyboard!
>
>   I have "setxkbmap -symbols 'en_US(pc102)+gb'" in my ~/.xsession,
>and « and » are available as AltGr-z and AltGr-x respectively.

.Xmodmap: keycode 117 = MultiKey

and then use [the Windows(R) Context Menu Key],[<],[<] to generate «
Cheers :)


Jan Engelhardt
-- 
--1283855629-1352548545-1124185618=:32120--
