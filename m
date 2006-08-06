Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWHFO4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWHFO4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 10:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWHFO4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 10:56:46 -0400
Received: from thunk.org ([69.25.196.29]:16602 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750903AbWHFO4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 10:56:45 -0400
Date: Sun, 6 Aug 2006 10:55:51 -0400
From: Theodore Tso <tytso@mit.edu>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, rlove@rlove.org, khali@linux-fr.org,
       gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060806145551.GC30009@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Shem Multinymous <multinymous@gmail.com>,
	Andrew Morton <akpm@osdl.org>, rlove@rlove.org, khali@linux-fr.org,
	gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060806005613.01c5a56a.akpm@osdl.org> <41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com> <20060806030749.ab49c887.akpm@osdl.org> <41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 01:44:02PM +0300, Shem Multinymous wrote:
> On 8/6/06, Andrew Morton <akpm@osdl.org> wrote:
> >I suggested a simple solution: Perhaps one of the other project members
> >(ie: one who uses a real name) could also sign off the patches?
> 
> Well, I offer this patch under the GPL, so anyone (including you) can do it.

But who is "I", and how do we know that you really do have the legal
authority to offer the patch under the GPL?  *That's* the whole point
of the DCO.  It is a lightweight version of what the FSF requires,
which is a legal contract asserting the same, with an ink signature
and (at least in some cases) notarized by a public notary.  The
contract has some interesting words in it, including ones where the
signer indemnifies the FSF against any claims for the work that has
been contributed, but it's all there to protect the FSF.

Some have claimed that the FSF approach is too slow, too heavyweight,
and discourages contributions, but there is good legal reasons for why
they ask that of their contributors.  I might not be willing to sign
the FSF's contract, but that's a personal matter between me and the
FSF.  (And given the FSF's position on the GPLv3 and my current
distaste of the discussion drafts, it's just as well that I don't
contribute code to the FSF.)

The DCO is a more lightweight mechanism, which tries to establish a
legal chain of accountability for patches.  But in order to do that,
we need to know who is making the assertion, and a pseudonym defeats
the whole point of the DCO.  No, we're not requiring an ink signature,
and no we're not requiring a notary public to check the identity of
the person signing the contract --- but then again, it's not that hard
to fake the driver's license which the notary public checks.  The
point is that there is a process, and that we ask for a certain level
of assurance.  The fact that the FSF doesn't require DNA samples
doesn't mean that they shouldn't stop doing what they are doing, just
as the fact that we aren't requiring ink signatures and public notary
checks doesn't mean we shouldn't stop doing what we are doing.

> Can you please be more specific? What purpose does this exclusion
> serve, that would be realistically achieved otherwise? You already
> have a GPL license from the author, and a way to contact and uniquely
> identify the author.

For legal reasons, we need a way to to contact and identify the author
in the real world, not just in cyberspace, and a pseudonym doesn't
meet that requirement.

						- Ted
