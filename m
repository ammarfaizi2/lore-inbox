Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131884AbRAHVZI>; Mon, 8 Jan 2001 16:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131677AbRAHVY6>; Mon, 8 Jan 2001 16:24:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:907 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131388AbRAHVYt>;
	Mon, 8 Jan 2001 16:24:49 -0500
Date: Mon, 8 Jan 2001 13:07:02 -0800
Message-Id: <200101082107.NAA21378@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: riel@conectiva.com.br
CC: hch@caldera.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva>
	(message from Rik van Riel on Mon, 8 Jan 2001 16:05:23 -0200 (BRDT))
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 8 Jan 2001 16:05:23 -0200 (BRDT)
   From: Rik van Riel <riel@conectiva.com.br>

   I really think the zerocopy network stuff should be ported
   to kiobuf proper.

That is how it could be done in 2.5.x, sure.

But this patch is intended for 2.4.x so "minimum impact"
applies.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
