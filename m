Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKFGJe>; Mon, 6 Nov 2000 01:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKFGJY>; Mon, 6 Nov 2000 01:09:24 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:1552 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129034AbQKFGJL>; Mon, 6 Nov 2000 01:09:11 -0500
Message-ID: <3A064B01.E8DCC9E3@egu.schule.ulm.de>
Date: Mon, 06 Nov 2000 07:09:05 +0100
From: Steffen Moser <moser@egu.schule.ulm.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: "ip_dynaddr" broken in 2.4.0-test10
In-Reply-To: <3A064279.30960692@egu.schule.ulm.de> <200011060522.VAA23103@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thank you for your fast answer!

"David S. Miller" wrote:

> Does this fix it?
> 
> echo "1" >/proc/sys/net/ipv4/ip_nonlocal_bind

I tried this - but no success. The problem persists...

Bye,
Steffen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
