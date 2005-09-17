Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVIQM22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVIQM22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVIQM22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:28:28 -0400
Received: from albireo.ucw.cz ([84.242.65.108]:25014 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751090AbVIQM22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:28:28 -0400
Date: Sat, 17 Sep 2005 14:28:28 +0200
From: Martin Mares <mj@ucw.cz>
To: =?iso-8859-2?B?Ik1hcnRpbiB2LiBM9ndpcyI=?= <martin@v.loewis.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-ID: <20050917122828.GA4103@ucw.cz>
References: <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432C0B51.704@v.loewis.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I'm not (only) talking about /bin/sh. I'm primarily talking about
> /usr/bin/python, /usr/bin/perl, and /usr/bin/wish. In all these
> languages, the interpreter *does* care about the encoding.

Agreed. On the other hand, in all these languages you can pass the encoding
as a parameter to the interpreter, cannot you?

> In the future, the signature *will* carry no information. But the future
> is, well, in the future.
> 
> I just can't understand why (some) people are so opposed to this patch.

Occam's razor?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"In accord to UNIX philosophy, PERL gives you enough rope to hang yourself." -- Larry Wall
