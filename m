Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129231AbQKXSM1>; Fri, 24 Nov 2000 13:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129428AbQKXSME>; Fri, 24 Nov 2000 13:12:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18705 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129145AbQKXSMA>; Fri, 24 Nov 2000 13:12:00 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
Date: 24 Nov 2000 09:41:48 -0800
Organization: Transmeta Corporation
Message-ID: <8vm98s$31u$1@penguin.transmeta.com>
In-Reply-To: <3A1DFDED.1C37EA7C@haque.net> <Pine.LNX.4.21.0011240047520.16450-100000@age.cs.columbia.edu> <20001124143557.A5614@win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001124143557.A5614@win.tue.nl>,
Guest section DW  <dwguest@win.tue.nl> wrote:
>
>(But I described the situation where the data on disk was correct
>and the date in core was not - almost certainly this is not an IDE problem.)

Ehh.. It only means that it would have been a read failure instead of a
write failure.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
