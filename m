Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129529AbQKWCyW>; Wed, 22 Nov 2000 21:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129927AbQKWCyN>; Wed, 22 Nov 2000 21:54:13 -0500
Received: from hera.cwi.nl ([192.16.191.1]:58337 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129529AbQKWCyJ>;
        Wed, 22 Nov 2000 21:54:09 -0500
Date: Thu, 23 Nov 2000 03:24:02 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011230224.DAA141466.aeb@aak.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: silly [< >] and other excess
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thats because too many things get put on a line then.
> And because we do [<foo>] [<bar>]  not   [<foo>][<bar>] ?

In the good old times we had  foo bar  for a total of 8*(8+1) = 72
positions. Now we have [<foo>] [<bar>] which takes 8*(8+1+4) = 104
positions. If you turned this into 6 items per line instead of 8,
it would certainly improve matters a bit.
Still..

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
