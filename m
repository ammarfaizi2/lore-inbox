Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132296AbRAGSW2>; Sun, 7 Jan 2001 13:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136300AbRAGSWS>; Sun, 7 Jan 2001 13:22:18 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:42148 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S132296AbRAGSWC>;
	Sun, 7 Jan 2001 13:22:02 -0500
Date: Sun, 7 Jan 2001 13:21:11 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <3A58BD44.1381D182@candelatech.com>
Message-ID: <Pine.GSO.4.30.0101071317440.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Ben Greear wrote:

> > Question: How do devices with hardware vlan support fit into your model ?
>
> I don't know of any, and I'm not sure how they would be supported.
>

erm, this is a MUST. You MUST factor the hardware VLANs and be totaly
802.1q compliant. Also of interest is 802.1P and D. We must have full
compliance, not some toy emulation.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
