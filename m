Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129373AbRCBSJQ>; Fri, 2 Mar 2001 13:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbRCBSJH>; Fri, 2 Mar 2001 13:09:07 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:23812 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129373AbRCBSI4>;
	Fri, 2 Mar 2001 13:08:56 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103021808.VAA00511@ms2.inr.ac.ru>
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 2 Mar 2001 21:08:42 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103021631.QAA01076@raistlin.arm.linux.org.uk> from "Russell King" at Mar 2, 1 04:31:07 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> same means its not the same bug?

It is the same, I think.


> If you still insist that it is purely a 2.2.15pre13 bug

I never said this. I said that your strace is _wrong_, how can I be
sure that tcpdump is not wrong too? You could understand this. 8)


> together to put 2.2.18 on this machine.  I can't guarantee when I'll
> be able to do this though.

You planned to make more accurate strace on Monday, if I remember correctly.
Now it is not necessary, Scott's one is enough to understand that
some problem exists and cannot be explained by buggy 2.2.15.


> PS, could you please spell my name correctly?

I bring apologies.

Alexey
