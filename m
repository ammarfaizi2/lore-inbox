Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310804AbSBRQHa>; Mon, 18 Feb 2002 11:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310803AbSBRQHV>; Mon, 18 Feb 2002 11:07:21 -0500
Received: from bitmover.com ([192.132.92.2]:12206 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310796AbSBRQHI>;
	Mon, 18 Feb 2002 11:07:08 -0500
Date: Mon, 18 Feb 2002 08:07:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020218080704.A13009@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020215153636.D32005@work.bitmover.com> <200202180941.KAA00769@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202180941.KAA00769@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Mon, Feb 18, 2002 at 10:41:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 10:41:03AM +0100, Rogier Wolff wrote:
> Larry McVoy wrote:
> > That's not what I mean.  But it's worthwhile to note that almost all
> > "rewrite from scratch" projects really translate into "I'm unwilling to
> > learn what the last guy did, and I'm smarter, so I'm going to do what
> > I want to do".  And that is not what kernel programmers do.  They would
> > love to be able to do that but it's very rare that doing so makes sense.
> 
> Sometimes the "old" code is set up in such a way that the "right" way
> to do it is not possible. 

_Sometimes_ that is true.  But there is no way you are going to be able to
say that that is the typical case.  History says otherwise.  I'm not saying
that rewrites aren't necessary, I'm saying that many, maybe most, aren't
necessary.

> I've heard that someone is trying to revolutionize "source code
> control systems". He's rewriting almost everything, and not enhancing
> any previous systems. What was his name again?

The fact that BitKeeper will read and write 30 year old SCCS files
seems to have escaped your attention.  Contrast that with the CML
debate and I think it makes my point perfectly.  If Eric's changes
worked the same way, we'd have a system which worked on the old data
and the new.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
