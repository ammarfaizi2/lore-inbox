Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbQKCAHm>; Thu, 2 Nov 2000 19:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQKCAHc>; Thu, 2 Nov 2000 19:07:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31899 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129440AbQKCAHS>;
	Thu, 2 Nov 2000 19:07:18 -0500
Date: Thu, 2 Nov 2000 15:52:38 -0800
Message-Id: <200011022352.PAA02403@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hpa@transmeta.com
CC: hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A0200F5.2D6F4F70@transmeta.com> (hpa@transmeta.com)
Subject: Re: select() bug
In-Reply-To: <E13rTfB-00023L-00@the-village.bc.nu> <3A01FC44.8A43FE8B@iname.com> <8tsupp$gh8$1@cesium.transmeta.com> <200011022346.PAA01451@pizda.ninka.net> <3A0200F5.2D6F4F70@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 02 Nov 2000 16:04:05 -0800
   From: "H. Peter Anvin" <hpa@transmeta.com>

   That's (very) nice, but it does assume there is currently a reader
   listening.

No, it has no such assumption.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
