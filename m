Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129483AbQKIBnC>; Wed, 8 Nov 2000 20:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKIBmm>; Wed, 8 Nov 2000 20:42:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38538 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129483AbQKIBmg>;
	Wed, 8 Nov 2000 20:42:36 -0500
Date: Wed, 8 Nov 2000 17:27:30 -0800
Message-Id: <200011090127.RAA17691@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
CC: morton@nortelnetworks.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011082031.XAA20453@ms2.inr.ac.ru> (kuznet@ms2.inr.ac.ru)
Subject: Re: [patch] NE2000
In-Reply-To: <200011082031.XAA20453@ms2.inr.ac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Wed, 8 Nov 2000 23:31:28 +0300 (MSK)

   [ Dave, please, look! I will strain brains this night too.
     Indeed, this sounds dubious. ]

Alexey!  Even someone understood all this already, look
to include/net/sock.h SOCK_SLEEP_{PRE,POST} macros :-)

I will compose a patch to fix all this.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
