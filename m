Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKPCXk>; Wed, 15 Nov 2000 21:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKPCX3>; Wed, 15 Nov 2000 21:23:29 -0500
Received: from hera.cwi.nl ([192.16.191.1]:2760 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129045AbQKPCXQ>;
	Wed, 15 Nov 2000 21:23:16 -0500
Date: Thu, 16 Nov 2000 02:53:10 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011160153.CAA107740.aeb@aak.cwi.nl>
To: aeb@veritas.com, torvalds@transmeta.com
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Cc: emoenke@gwdg.de, eric@andante.org, koenig@tat.physik.uni-tuebingen.de,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anybody else willing to finish this one off?

If noone else does, I suppose I can.

(> .. gets ENOENT ..
and that is not because it only is a partial image?)

Andries


PS - Yesterday I complained that 2.4.0test9 was fine
but 2.4.0test11pre5 dies as soon as it has to forward a ping.
The effect is reproducible, and 2.4.0test10 is also fine.
I see no changes in the netfilter code.
Will look some more into this tomorrow.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
