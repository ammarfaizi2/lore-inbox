Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132605AbRDKPTA>; Wed, 11 Apr 2001 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132613AbRDKPSu>; Wed, 11 Apr 2001 11:18:50 -0400
Received: from deckard.concept-micro.com ([62.161.229.193]:15400 "EHLO
	deckard.concept-micro.com") by vger.kernel.org with ESMTP
	id <S132605AbRDKPSl>; Wed, 11 Apr 2001 11:18:41 -0400
Message-ID: <XFMail.20010411171302.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C1A1@pcmailsrv1.sac.unify.com>
Date: Wed, 11 Apr 2001 17:13:02 +0200 (MEST)
X-Face: #eTSL0BRng*(!i1R^[)oey6`SJHR{3Sf4dc;"=af8%%;d"%\#"Hh0#lYfJBcm28zu3r^/H^
 d6!9/eElH'p0'*,L3jz_UHGw"+[c1~ceJxAr(^+{(}|DTZ"],r[jSnwQz$/K&@MT^?J#p"n[J>^O[\
 "%*lo](u?0p=T:P9g(ta[hH@uvv
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: "Manuel A. McLure" <mmt@unify.com>
Subject: RE: Still IRQ routing problems with VIA
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 10-Apr-2001, Manuel A. McLure écrivait :
> This may be the difference - I always set "Plug-n-Play OS: No" on all my
> machines. Linux works fine and it doesn't seem to hurt Windows 98 any.

I've been told it affects the way IRQs are assigned; With "PnP OS: No", some
boards (seen on several Asus mainboards, ie Phoenix-Award BIOS) try to
share IRQs as much as possible; It usually works, but the performance may
suffer a bit.



-- 
We are the dot in 0.2 Kb/s
