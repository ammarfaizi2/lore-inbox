Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTIAQYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTIAQYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:24:15 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:20142 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263011AbTIAQYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:24:09 -0400
Date: Mon, 1 Sep 2003 18:22:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Larry McVoy <lm@bitmover.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, ak@suse.de
Subject: Re: bitkeeper comments
In-Reply-To: <20030901161144.GD1327@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0309011820010.5048-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Larry McVoy wrote:
> On Mon, Sep 01, 2003 at 05:02:18PM +0100, Christoph Hellwig wrote:
> > On Mon, Sep 01, 2003 at 08:59:15AM -0700, Larry McVoy wrote:
> > > Hey, I'm not in the middle of this because I don't understand who is right
> > > and it's not my place to make that call.
> > 
> > I doesn't matter who's actually right.  If Andi was wrong Albert can
> > demand a apology from him or sue him or whater (not that his name is
> > actually mentioned in the message).
> > 
> > But we're not going to retroactively censor commit messages.
> 
> I'm confused, I thought Linus/Marcelo/Andrew were the tree maintainers.
> As long as they are they get to make the call, not you (or me or whoever).

Retroactively changing a commit message may be a dangerous precedent. While
there may be legitimate reasons (E.g. plain wrong comments or `actually this
part was not written by x but by y'), one day The Evil Empire may claim we
changed the evidence of who did what.

Putting comments under revision control is another option, but may be too
deep-involving...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

