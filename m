Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131901AbRAHWkD>; Mon, 8 Jan 2001 17:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135745AbRAHWjy>; Mon, 8 Jan 2001 17:39:54 -0500
Received: from anime.net ([63.172.78.150]:57356 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S131901AbRAHWjm>;
	Mon, 8 Jan 2001 17:39:42 -0500
Date: Mon, 8 Jan 2001 14:40:58 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: Michael Meissner <meissner@spectacle-pond.org>, Ookhoi <ookhoi@dds.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The advantage of modules?
In-Reply-To: <200101082214.WAA00962@raistlin.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0101081437030.19618-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Russell King wrote:
> Seriously though, you can't depreciate a term for referring to a type of
> bus without providing some other term to describe said bus.

You need to distinguish between SCSI-the-protocol and
SCSI-the-physical-layer. The term "SCSI" alone is simply too ambiguous to
be really useful anymore. I think you can use term "SCSI-1" or "SCSI-2"
when specicfally meaning SCSI protocol over classic 50 wire layer.

Saying "SCSI does not support hotplug" is very misleading.

Right now, the term "SCSI" is more akin to "IP".

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
