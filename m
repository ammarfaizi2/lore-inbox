Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132078AbRAGQcZ>; Sun, 7 Jan 2001 11:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbRAGQcP>; Sun, 7 Jan 2001 11:32:15 -0500
Received: from gleb.nbase.co.il ([194.90.136.56]:55047 "EHLO gleb.nbase.co.il")
	by vger.kernel.org with ESMTP id <S132078AbRAGQcG>;
	Sun, 7 Jan 2001 11:32:06 -0500
From: Gleb Natapov <gleb@nbase.co.il>
Date: Sun, 7 Jan 2001 18:30:32 +0200
To: jamal <hadi@cyberus.ca>
Cc: "David S. Miller" <davem@redhat.com>, ak@suse.de, greearb@candelatech.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010107183032.E28257@nbase.co.il>
In-Reply-To: <200101070543.VAA24689@pizda.ninka.net> <Pine.GSO.4.30.0101071026070.18916-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0101071026070.18916-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Jan 07, 2001 at 10:56:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 10:56:23AM -0500, jamal wrote:
[snip]
> 
> I used to be against VLANS being devices, i am withdrawing that comment; it's
> a lot easier to look on them as devices if you want to run IP on them. And
> in this case, it makes sense the possibilirt of  over a thousand devices
> is good.
>

Glad to hear :) So perhaps this is a good time to move one of VLAN implementations
into the official kernel?

--
			Gleb.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
