Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129967AbQLHDGh>; Thu, 7 Dec 2000 22:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131187AbQLHDG2>; Thu, 7 Dec 2000 22:06:28 -0500
Received: from hera.cwi.nl ([192.16.191.1]:11508 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129967AbQLHDGJ>;
	Thu, 7 Dec 2000 22:06:09 -0500
Date: Fri, 8 Dec 2000 03:35:09 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200012080235.DAA157231.aeb@aak.cwi.nl>
To: aeb@veritas.com, viro@math.psu.edu
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, if you still have 1.7, 1.10, 1.13 and 1.14...

See ftp://ftp.cwi.nl/pub/aeb/manpages/ (will soon disappear again).

> BTW, could we finally lose mpx(2)?

Maybe we lost it - I find sys_mpx only in a comment in arch/arm/kernel/calls.S

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
