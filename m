Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLDTRf>; Mon, 4 Dec 2000 14:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQLDTRZ>; Mon, 4 Dec 2000 14:17:25 -0500
Received: from 62-6-229-244.btconnect.com ([62.6.229.244]:22788 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129391AbQLDTRK>;
	Mon, 4 Dec 2000 14:17:10 -0500
Date: Mon, 4 Dec 2000 18:48:38 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Attempt to hard link across filesystems results in
In-Reply-To: <E1430Rm-00047P-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012041839220.1177-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000, Alan Cox wrote:

> > Second attempt, the first one failed due to stupid setup of ISP and the
> > usage of mail-abuse.org which blocks anything that has no reverse DNS
> > lookup. So some of my messages (about 20%) get lost and I have to resend
> > them when I feel it's been too quiet :)
> 
> mail-abuse doesnt do this. One thing it does do however is provide block lists
> of addresses where the ISP has said 'this should not be direct mail sources'.

Alan, I thank you for sparing a minute to enlighten me. But the _only_
thing I do not understand still (and it appears to be critical) is why it
only happens sometimes but not others? i.e. in both times I dialled to
btconnect.com and faked From: tigran@veritas.com (via pine(1) setup).
Sometimes it gets through to linux-kernel and sometimes it does not. E.g.
this second attempt was sent under exactly the same conditions as the
first one. So I was justified in assuming (wrongly as you say) that
something external to me was different and the only external thing was
dynamic ip address assigned to the ISDN interface of the router. (so I
made the assumption that in one case it was lookupable and in another it
was not, maybe this assumption is totally broken, i.e. nothing would work
if I was _ever_ assigned such address)

So, I am still not wiser as to what to do (other than admit to being
@btconnect.com :) to make all my messages safely reach
linux-kernel. Btconnect.com people also seems to have absolutely no clue
so far, unfortunately (probably both me and they are too lazy to (re)read
Stevence's TCP/IP Illustrated Volume I and understand how DNS and SMTP are
supposed to cooperate).

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
