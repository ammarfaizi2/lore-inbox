Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKBRin>; Thu, 2 Nov 2000 12:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129086AbQKBRid>; Thu, 2 Nov 2000 12:38:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36356 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129047AbQKBRiW>; Thu, 2 Nov 2000 12:38:22 -0500
Date: Thu, 2 Nov 2000 09:38:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Thomas Sailer <sailer@ife.ee.ethz.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <3A017443.8E436A97@ife.ee.ethz.ch>
Message-ID: <Pine.LNX.4.10.10011020937410.1432-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Nov 2000, Thomas Sailer wrote:
>
> The OSS API (http://www.opensound.com/pguide/oss.pdf, page 102ff)
> specifies that a select _with the sounddriver's filedescriptor
> set in the read mask_ should start the recording.

So fix the stupid API.

The above is just idiocy.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
