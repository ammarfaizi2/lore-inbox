Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSHEMju>; Mon, 5 Aug 2002 08:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318558AbSHEMju>; Mon, 5 Aug 2002 08:39:50 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:58266 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318516AbSHEMjt> convert rfc822-to-8bit; Mon, 5 Aug 2002 08:39:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Aaron Denny <euphguy86@yahoo.com>
Subject: Re: ppp problem
Date: Mon, 5 Aug 2002 14:42:56 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208051442.56655.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

> Hi, i recently updated my kernel to 2.4.9 from 2.2.13,
> quite a large jump obviously, im in slackware 7.0, ok
> so here is my problem. after updating the kernel i did
> ppp-go, it dialed and i heard the noise that it makes
> when its dialing an ISP then at the end, it says:
> seriel connection made then on the next line i get:
> Couldn't attach tty to PPP unit 0: invalid argument

> i know i put ppp support in and unixpty when i
> installed the kernel help me pleease
We can help you, IF you submit ALOT more information, f.e.:

- Kernel .config
- lspci -vvv
- what software you exactly use to call to your ISP.
  (what the hell is ppp-go?) ;) ... updating this ones?

Maybe you want to use a newer kernel? 2.4.9 is evil old you know?! :)

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
