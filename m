Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSFXO3E>; Mon, 24 Jun 2002 10:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSFXO3D>; Mon, 24 Jun 2002 10:29:03 -0400
Received: from n123.ols.wavesec.net ([209.151.19.123]:28544 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S313305AbSFXO3D>;
	Mon, 24 Jun 2002 10:29:03 -0400
Date: Sun, 23 Jun 2002 13:50:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] quotemarks and trailing whitespaces (1st, revisited)
Message-ID: <20020623115039.GA2799@elf.ucw.cz>
References: <Pine.LNX.4.44.0206121520480.30784-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206121520480.30784-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I redid the quotemark patch. Since I'm a lazy typist, I had a script which
> removed all whitespaces before virtual or real newline characters. Does
> this one look OK to you?

Perhaps such patch should go to scripts/ in distribution, so when
someone finishes big cleanup for driver can run it at the same time?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
