Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130499AbQLFURF>; Wed, 6 Dec 2000 15:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130562AbQLFUQ4>; Wed, 6 Dec 2000 15:16:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9994 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130499AbQLFUQs>; Wed, 6 Dec 2000 15:16:48 -0500
Date: Wed, 6 Dec 2000 11:46:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.LNX.4.21.0012060904550.1044-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.10.10012061145010.1917-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Tigran Aivazian wrote:
> 
> This patch combines your previous patch with 2 changes I have just
> suggested. Both changes are obvious (and correct).

Why remove the EROFS test?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
