Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbQKFHNC>; Mon, 6 Nov 2000 02:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKFHMw>; Mon, 6 Nov 2000 02:12:52 -0500
Received: from waste.org ([209.173.204.2]:24864 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129161AbQKFHMo>;
	Mon, 6 Nov 2000 02:12:44 -0500
Date: Mon, 6 Nov 2000 01:12:14 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Keith Owens <kaos@ocs.com.au>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <2508.973474129@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.10.10011060109080.8248-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Keith Owens wrote:

> What do people think, do we need module persistent storage?

Hopefully not. The standard examples (mixer levels, etc) are better
handled with a userspace tool hooked by modprobe. This even gets
persistence across reboots if that's what's wanted.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
