Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136452AbRAHBkh>; Sun, 7 Jan 2001 20:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136463AbRAHBk1>; Sun, 7 Jan 2001 20:40:27 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:61155 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S136452AbRAHBkM>; Sun, 7 Jan 2001 20:40:12 -0500
Date: Mon, 8 Jan 2001 02:40:34 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Ulrich Drepper <drepper@cygnus.com>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <m3n1d27s1e.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.4.30.0101080237070.16904-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Ulrich Drepper wrote:

> Why don't you, as the other script suggested, execute libc.so.6?
> Symlinks can be missing or can be wrong.

I'll have a look at this shell script and take the best out of both to
make a new one.

BTW, lots of version dependencies found in older Changes document (i.e.
for 2.3.11) were removed now (2.4.0 shows only 9 where the old one had
22). Have the removed ones been completely unnecessary?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
