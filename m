Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290756AbSBFTqH>; Wed, 6 Feb 2002 14:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSBFTp5>; Wed, 6 Feb 2002 14:45:57 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:24962
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S290756AbSBFTpf>; Wed, 6 Feb 2002 14:45:35 -0500
Date: Wed, 6 Feb 2002 12:45:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020206194515.GJ1447@opus.bloom.county>
In-Reply-To: <20020206000343.I14622@work.bitmover.com> <200202061935.g16JZLh18377@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202061935.g16JZLh18377@ns.caldera.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 08:35:21PM +0100, Christoph Hellwig wrote:
> In article <20020206000343.I14622@work.bitmover.com> you wrote:
> >> I second that. Maybe however we can have it both ways -- I have no
> >> experience with bk, but can't this same info be made available elsewhere
> >> like a public web interface or some such thing?
> >
> > I've put up read-only clones on 
> >
> > 	http://linux.bkbits.net
> >
> > you can go there and get the changelogs in web form.  I just figured out
> > what a bad choice 8088 was for a port and we'll be moving stuff over to
> > 8080 since that seems to go through more firewalls.
> 
> Btw, is there a generic way to move repos cloned from Ted's (now
> orphaned?) 2.4 tree to Linus' official one?

Working under the assuming that Linus started his own tree first and
didn't grab Ted's, no.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
