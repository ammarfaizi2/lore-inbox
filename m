Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUI0RgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUI0RgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUI0RgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:36:06 -0400
Received: from mail1.kontent.de ([81.88.34.36]:40078 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266674AbUI0RgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:36:01 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux PM core problems
Date: Mon, 27 Sep 2004 19:34:32 +0200
User-Agent: KMail/1.6.2
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>,
       "" <greg@kroah.com>
References: <Pine.LNX.4.44L0.0409252323180.15218-100000@netrider.rowland.org> <200409270952.35467.david-b@pacbell.net> <Pine.LNX.4.50.0409270953140.32506-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0409270953140.32506-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409271934.32759.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. September 2004 19:02 schrieb Patrick Mochel:
> 
> On Mon, 27 Sep 2004, David Brownell wrote:
> 
> > What, the audience that understands USB shouldn't be expected
> > to (a) discuss USB-related PM issues, except on non-USB lists; or
> > (b) involve developers who know other parts of PM?  Nonsense.
> 
> I didn't say that. But, the thread (especially given the Subject) is about
> how the core works. And, most of the relevant USB people seem to be on
> linux-kernel, or can easily be cc'd as well. And, what about Benh, who has
> suffered through this problems on ppc for just as long?

OK, the cc list can easily be extended.

[..]
> > There's been a notable lack of discussion about USB-related PM issues,
> > except in these recent threads.  So "read the archives" isn't constructive.
> 
> This thread seems to lack USB-centricity. I know you've read the archives
> and have participated in the discussions. But most, if not all, of the
> ideas have come up in one form or another (though many with poor timing).
> We're re-hashing the same discussion over and over. Not that that is a bad
> thing, because eventually someone will get sick of reading it all just fix
> the stupid code.
> 
> My issue is that core problems are being talked about on a splinter list
> and they should move to linux-kernel. But, if we're going to do that, it's
> imperative to understand the history and the context, and know that we
> have the same problem as we did 4 years ago (albeit with a different
> playing field).

Why? What makes this field so hard?
Would you be happy if we listed the problems USB has with the current code?

	Regards
		Oliver
