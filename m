Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWHFRIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWHFRIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 13:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWHFRIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 13:08:14 -0400
Received: from 1wt.eu ([62.212.114.60]:38925 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751654AbWHFRIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 13:08:13 -0400
Date: Sun, 6 Aug 2006 18:55:06 +0200
From: Willy Tarreau <w@1wt.eu>
To: Olaf Hering <olaf@aepfle.de>
Cc: Theodore Tso <tytso@mit.edu>, Shem Multinymous <multinymous@gmail.com>,
       Andrew Morton <akpm@osdl.org>, rlove@rlove.org, khali@linux-fr.org,
       gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060806165506.GD8776@1wt.eu>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060806005613.01c5a56a.akpm@osdl.org> <41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com> <20060806030749.ab49c887.akpm@osdl.org> <41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com> <20060806145551.GC30009@thunk.org> <20060806164013.GA7637@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806164013.GA7637@aepfle.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 06:40:13PM +0200, Olaf Hering wrote:
> On Sun, Aug 06, 2006 at 10:55:51AM -0400, Theodore Tso wrote:
> > On Sun, Aug 06, 2006 at 01:44:02PM +0300, Shem Multinymous wrote:
> 
> > > Can you please be more specific? What purpose does this exclusion
> > > serve, that would be realistically achieved otherwise? You already
> > > have a GPL license from the author, and a way to contact and uniquely
> > > identify the author.
> > 
> > For legal reasons, we need a way to to contact and identify the author
> > in the real world, not just in cyberspace, and a pseudonym doesn't
> > meet that requirement.
> 
> In that context, even an anonymous mailer like gmail and the like is
> questionable. But, I'm sure one get a domain with faked address data
> in the whois database.
> Where would you draw the line?

I think that if we have the date, the name, and Gmail has the logs, it
should be enough to get back to the real persons in case of future legal
trouble. Anyway, it's clearly possible that many contributors already
post under pseudonyms which do not designate them in person. After all,
it is already more or less the case for all those with non-latin alphabets.
Perhaps the only thing we're missing is a list of validated mail account
providers ? Anyway, how do we now that someone hosted by local provider X
my be mapped to a physical person ?

Maybe we should only make the difference between "intentionnal anonymity"
and free mail accounts, if this is possible.

Regards,
Willy

