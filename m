Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263145AbRE1UxV>; Mon, 28 May 2001 16:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbRE1UxL>; Mon, 28 May 2001 16:53:11 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:59697 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S263143AbRE1UxG>; Mon, 28 May 2001 16:53:06 -0400
From: "Ronald Bultje" <rbultje@ronald.bitfreak.net>
To: "Ricky Beam" <jfbeam@bluetopia.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [2.4.5] buz.c won't compile
Date: Mon, 28 May 2001 22:57:59 +0200
Message-ID: <CDEJIPDFCLGDNEHGCAJPKEDJCBAA.rbultje@ronald.bitfreak.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.04.10105281512050.1601-100000@beaker.bluetopia.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Actually, it broke at 2.4.3.  Go look at the first change to buz.c from
>that patch.

None at all. It didn't break at 2.4.3, it just didn't compile at all anymore
in 2.4.3. It was already kind of broken before that.

>PS: I really hate it when people break "functional" things in the >"stable"
>tree. (functional and stable are both open to debate.)

Nobody broke it. The fact that it didn't compile right was something nobody
ever looked at - it was already broken before and I really don't suppose
anyone uses it.
The words "if it compiles, it'll work" are not true. Really.

Ronald

PS, how about just removing it from the kernel? Would spare a lot of
troubles, and nobody uses it anyway :-).

