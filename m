Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRKMTEM>; Tue, 13 Nov 2001 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278239AbRKMTEC>; Tue, 13 Nov 2001 14:04:02 -0500
Received: from weta.f00f.org ([203.167.249.89]:22680 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S278269AbRKMTDw>;
	Tue, 13 Nov 2001 14:03:52 -0500
Date: Wed, 14 Nov 2001 08:05:05 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
Message-ID: <20011114080505.A18098@weta.f00f.org>
In-Reply-To: <20011112232539.A14409@redhat.com> <Pine.LNX.4.33.0111130903350.16316-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111130903350.16316-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 09:04:33AM -0800, Linus Torvalds wrote:

    I don't like reformatting without at least asking the maintainer,
    unless the maintainer isn't doing maintenance. Also, right now I'd
    rather not have any big patches even if they are just
    syntactic.. Makes hand-over to Marcelo simpler.

If (at some point) people do want coding-style patches then there are
MANY places (eg. entire filesystem sub-trees) which could have
white-space alignment changes and similar things....



  --cw
