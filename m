Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRKMRJD>; Tue, 13 Nov 2001 12:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRKMRIx>; Tue, 13 Nov 2001 12:08:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6670 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276956AbRKMRIs>; Tue, 13 Nov 2001 12:08:48 -0500
Date: Tue, 13 Nov 2001 09:04:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
In-Reply-To: <20011112232539.A14409@redhat.com>
Message-ID: <Pine.LNX.4.33.0111130903350.16316-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Nov 2001, Benjamin LaHaise wrote:
>
> Please incorporate this patch to make mtrr.c conform to the standards set
> forth in Documentation/CodingStyle which make it much more appealing to
> the eyes.  Cheers,

I don't like reformatting without at least asking the maintainer, unless
the maintainer isn't doing maintenance. Also, right now I'd rather not
have any big patches even if they are just syntactic.. Makes hand-over to
Marcelo simpler.

		Linus

