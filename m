Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbVLXJow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbVLXJow (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 04:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbVLXJov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 04:44:51 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:23747 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1422644AbVLXJou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 04:44:50 -0500
From: Junio C Hamano <junkio@cox.net>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.0.0b quickfix
References: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>
	<1135244363.10035.185.camel@gaston>
	<Pine.LNX.4.64.0512220945450.4827@g5.osdl.org>
	<200512231712.40621.ioe-lkml@rameria.de>
Date: Sat, 24 Dec 2005 01:44:48 -0800
Message-ID: <7vu0cyu8vj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

> Also sucks because letters after numbers a read as "units".
>
> Just compare 5h, 3kg, 20cm, 9in, 1.3h

If your first reaction after seeing 0.99.7a 0.99.7b 0.99.7c was
that they were numbers in unrelated units a b c and cannot be
compared with each other, you need to get your head examined ;-).

I concede that it is a cute point you tried to make [*1*], but I
do not think your presentation was convincing enough.

[Footnote]

*1* Which one is the heaviest, 5h, 3kg, or 20cm?

