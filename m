Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130443AbRAITU0>; Tue, 9 Jan 2001 14:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131697AbRAITUT>; Tue, 9 Jan 2001 14:20:19 -0500
Received: from chiara.elte.hu ([157.181.150.200]:30732 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130766AbRAITUF>;
	Tue, 9 Jan 2001 14:20:05 -0500
Date: Tue, 9 Jan 2001 20:19:44 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Christoph Hellwig <hch@caldera.de>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109192707.A20536@caldera.de>
Message-ID: <Pine.LNX.4.30.0101092015020.7724-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Christoph Hellwig wrote:

> I didn't want to suggest that - I'm to clueless concerning networking
> to even consider an internal design for network zero-copy IO. I'm just
> talking about the VFS interface to the rest of the kernel.

(well, i think you just cannot be clueless about one and then demand
various things about the other...)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
