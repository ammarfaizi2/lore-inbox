Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbTIAR2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTIAR2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:28:38 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:38664 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263070AbTIAR2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:28:32 -0400
Date: Mon, 1 Sep 2003 18:28:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       Larry McVoy <lm@work.bitmover.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Larry McVoy <lm@bitmover.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: bitkeeper comments
Message-ID: <20030901182827.A26176@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>,
	Larry McVoy <lm@work.bitmover.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	ak@suse.de
References: <20030901170218.A24713@infradead.org> <Pine.LNX.4.44.0309010956390.7908-100000@home.osdl.org> <20030901172334.GE14716@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901172334.GE14716@unthought.net>; from jakob@unthought.net on Mon, Sep 01, 2003 at 07:23:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 07:23:34PM +0200, Jakob Oestergaard wrote:
> There is an important difference.
> 
> If I send you a mail saying "X" and you change it to say "Y" and put "Y"
> in the source tree, fine.  It was a mail between us, noone except you
> and me will know.  If I think it's wrong, maybe I can make you submit
> "X" to the source tree instead, with an explanation.
> 
> Everything that was ever publicly visible, stays publicly visible, even
> with the the revised comments, thanks to the revision history.
> 
> But changing the source tree revision history retroactively, that's bad.
> It defies the purpose of revision control itself.
> 
> The source tree is a public record. People will remember "this said 'Y'
> I'm sure, but now it says 'X', why is that?" - and noone can answer.
> History forgotten.

Yupp, that's what I meant.  I certainly don't want a thought police
on my source trees.

