Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbQKFFi0>; Mon, 6 Nov 2000 00:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKFFiR>; Mon, 6 Nov 2000 00:38:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24255 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129036AbQKFFiK>;
	Mon, 6 Nov 2000 00:38:10 -0500
Date: Sun, 5 Nov 2000 21:22:52 -0800
Message-Id: <200011060522.VAA23103@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: moser@egu.schule.ulm.de
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A064279.30960692@egu.schule.ulm.de> (message from Steffen Moser
	on Mon, 06 Nov 2000 06:32:41 +0100)
Subject: Re: "ip_dynaddr" broken in 2.4.0-test10
In-Reply-To: <3A064279.30960692@egu.schule.ulm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does this fix it?

echo "1" >/proc/sys/net/ipv4/ip_nonlocal_bind

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
