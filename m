Return-Path: <linux-kernel-owner+w=401wt.eu-S1754291AbWLRRC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbWLRRC6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 12:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbWLRRC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 12:02:58 -0500
Received: from thunk.org ([69.25.196.29]:45191 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290AbWLRRC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 12:02:57 -0500
Date: Mon, 18 Dec 2006 12:02:23 -0500
From: Theodore Tso <tytso@mit.edu>
To: Dave Neuer <mr.fred.smoothie@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alexandre Oliva <aoliva@redhat.com>,
       Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
Message-ID: <20061218170222.GB18255@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dave Neuer <mr.fred.smoothie@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Alexandre Oliva <aoliva@redhat.com>,
	Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org> <orwt4qaara.fsf@redhat.com> <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org> <161717d50612180738y4feec39dp5d1d090409a9e074@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161717d50612180738y4feec39dp5d1d090409a9e074@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 10:38:38AM -0500, Dave Neuer wrote:
> I think this is the key, both with libraries and w/ your book example
> below; the concept of independant "meaning." If your code doesn't do
> whatever it is supposed to do _unless_ it is linked with _my_ code,
> then it seems fairly clear that your code is derivative of mine, just
> as your sequel to my novel (or your pages added onto my book) don't
> "mean" anything if someone hasn't read mine.

That's a wonderful theory, but I don't believe it's recognized by the
courts.  I'm also pretty sure you don't want to go there.  Consider
folks who create add-ons to Tivo player, or extensions to MacOS.  They
don't _do_ anything unless they are used with the Tivo player.  Or a
game meant for a Playstation 3; it won't _do_ anything unless it's
calls the BIOS and system functions provided by the PS3.  Does that
automatically make them derived works?

What about a GPL'ed program which interfaces with the iTunes server?
It won't _do_ anything unless it can connect across the network and
talks to iTunes code.  Does that make it a derived work?

If the answer is no --- or should be no --- then maybe you should be
more careful before making such statements.

For myself, I believe we actually get the largest amount of
programming freedom if we use a very tightly defined definition of
derived code, and not try to create new expansive definitions and try
to ram them through the court system or through legislatures.  In the
end, we may end up regretting it.

						- Ted
