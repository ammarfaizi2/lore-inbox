Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132685AbRAGQhf>; Sun, 7 Jan 2001 11:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135192AbRAGQhQ>; Sun, 7 Jan 2001 11:37:16 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:36772 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S132685AbRAGQhL>;
	Sun, 7 Jan 2001 11:37:11 -0500
Date: Sun, 7 Jan 2001 11:36:23 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Gleb Natapov <gleb@nbase.co.il>
cc: "David S. Miller" <davem@redhat.com>, <ak@suse.de>,
        <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <20010107183032.E28257@nbase.co.il>
Message-ID: <Pine.GSO.4.30.0101071134210.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Gleb Natapov wrote:

> > I used to be against VLANS being devices, i am withdrawing that comment; it's
> > a lot easier to look on them as devices if you want to run IP on them. And
> > in this case, it makes sense the possibilirt of  over a thousand devices
> > is good.
> >
>
> Glad to hear :) So perhaps this is a good time to move one of VLAN implementations
> into the official kernel?
>

Absolutely.
I think we need a VLAN implementation in there.

cheers,
jamal


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
