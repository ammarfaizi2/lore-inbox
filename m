Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbRAZU50>; Fri, 26 Jan 2001 15:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130959AbRAZU5S>; Fri, 26 Jan 2001 15:57:18 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:41477 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S130870AbRAZU5F>; Fri, 26 Jan 2001 15:57:05 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200101262057.MAA02372@cx518206-b.irvn1.occa.home.com>
Subject: Re: Possible Bug:  drivers/sound/maestro.c
To: fd0man@crosswinds.net (Michael B. Trausch)
Date: Fri, 26 Jan 2001 12:57:02 -0800 (PST)
Cc: georgn@somanetworks.com (Georg Nikodym), linux-kernel@vger.kernel.org,
        alan@redhat.com (Alan Cox), zab@redhat.com (Zack Brown)
Reply-To: barryn@pobox.com
In-Reply-To: <Pine.LNX.4.21.0101261245250.399-100000@fd0man.accesstoledo.com> from "Michael B. Trausch" at Jan 26, 2001 12:47:54 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael B. Trausch wrote:
[snip]
> 2.4.0 still does it - not as often, but it still does it.  I'm compiling a
[snip]

I haven't done any sound stuff with 2.4 on my Dell Inspiron 5000e, but I
have this problem (or a similar one, anyway -- sometimes the sound becomes
distorted or comes only through one speaker) under both Linux 2.2 and
Win2K. If it was just Linux, I'd assume it was a driver problem, but the
fact that I'm getting very similar misbehavior from both Linux and Win2K
(I don't have Win98 or ME on the machine, so I can't test that) makes me
really wonder...

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
