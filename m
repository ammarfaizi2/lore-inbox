Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbQKGEnG>; Mon, 6 Nov 2000 23:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbQKGEmr>; Mon, 6 Nov 2000 23:42:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21889 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130466AbQKGEmf>;
	Mon, 6 Nov 2000 23:42:35 -0500
Date: Mon, 6 Nov 2000 20:28:09 -0800
Message-Id: <200011070428.UAA01710@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jordy@napster.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A07662F.39D711AE@napster.com> (message from Jordan Mendelson on
	Mon, 06 Nov 2000 18:17:19 -0800)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 06 Nov 2000 18:17:19 -0800
   From: Jordan Mendelson <jordy@napster.com>

   18:54:57.394894 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: .
   2429:2429(0) ack 506 win 6432 <nop,nop, sack 1 {456:506} > (DF)

And this is it?  The connection dies right here and says no
more?  Surely, there was more said on this connection after
this point.

Otherwise I see nothing obviously wrong in these dumps.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
