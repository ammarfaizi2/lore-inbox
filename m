Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143685AbRAHNJU>; Mon, 8 Jan 2001 08:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143686AbRAHNJK>; Mon, 8 Jan 2001 08:09:10 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:61092 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S143685AbRAHNJE>;
	Mon, 8 Jan 2001 08:09:04 -0500
Date: Mon, 8 Jan 2001 08:08:12 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: David Ford <david@linux.com>
cc: Andi Kleen <ak@suse.de>, Chris Wedgwood <cw@f00f.org>,
        "David S. Miller" <davem@redhat.com>, <greearb@candelatech.com>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <Pine.LNX.4.10.10101072232330.12242-100000@Huntington-Beach.Blue-Labs.org>
Message-ID: <Pine.GSO.4.30.0101080806440.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, David Ford wrote:

> Distributions should be encouraged to use ip rather than ifconfig/route.  It
> works better and does more, the output is more informative, more concise,
> and less confusing.  It doesn't take that much more disk space than ifconfig
> and route does, ifconfig and route take 74K, ip takes 89K. I don't think 15k
> of disk space is sufficient concern, given that inodes are probably page
> size.

Actually if you count arp which is also part of ip; ip becomes smaller
by about 15K.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
