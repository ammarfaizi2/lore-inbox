Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbRBBElr>; Thu, 1 Feb 2001 23:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBBElh>; Thu, 1 Feb 2001 23:41:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:15367 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129067AbRBBElb>; Thu, 1 Feb 2001 23:41:31 -0500
Date: Fri, 2 Feb 2001 00:51:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: sard on kernel 2.4
Message-ID: <Pine.LNX.4.21.0102012322560.18665-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

There is a significative amount of people who use sard's additional block
layer statistics (I'm one of them). It would be nice to have it in the
official free.

The available sard code is not optional, which I believe is a valid reason
for not merging it in.

If so, I can make it optional and documented in Configure.help so the
this problem is gone.

Any other reason why you would not merge it in the official tree ?

If no, I can send you the proposed patch.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
