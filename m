Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265682AbRF1M4N>; Thu, 28 Jun 2001 08:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbRF1MzY>; Thu, 28 Jun 2001 08:55:24 -0400
Received: from deckard.concept-micro.com ([62.161.229.193]:2680 "EHLO
	deckard.concept-micro.com") by vger.kernel.org with ESMTP
	id <S265682AbRF1MzN>; Thu, 28 Jun 2001 08:55:13 -0400
Message-ID: <XFMail.20010628145528.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B38A988.A576028B@uu.net>
Date: Thu, 28 Jun 2001 14:55:28 +0200 (CEST)
X-Face: #eTSL0BRng*(!i1R^[)oey6`SJHR{3Sf4dc;"=af8%%;d"%\#"Hh0#lYfJBcm28zu3r^/H^
 d6!9/eElH'p0'*,L3jz_UHGw"+[c1~ceJxAr(^+{(}|DTZ"],r[jSnwQz$/K&@MT^?J#p"n[J>^O[\
 "%*lo](u?0p=T:P9g(ta[hH@uvv
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: Alex Deucher <adeucher@UU.NET>
Subject: Re: AMD thunderbird oops
Cc: linux-kernel@vger.kernel.org, joeja@mindspring.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 26-Jun-2001, Alex Deucher écrivait :
> What's weird though is that it is rock solid as long as I don't use
> athlon optimizations.

Some ASUS boards (mostly P3B-F) would either freeze or self reboot when using
PhotoShop 5. Everything else would run perfectly.

Disabling MMX optimizations in this software would "solve" the problem. Another
solution found on the web (sorry, I don't have the URL at hand) is to add two
or three additionnal capacitors on the back of the board, to solve the electric
instabilities that cause the reboots.

So yes, I can believe that that sort of "corner case" problems exist.

Best regards,
Pierre.


-- 
We are the dot in 0.2 Kb/s
