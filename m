Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290671AbSBFQyu>; Wed, 6 Feb 2002 11:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290669AbSBFQyk>; Wed, 6 Feb 2002 11:54:40 -0500
Received: from bitmover.com ([192.132.92.2]:65466 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290665AbSBFQy0>;
	Wed, 6 Feb 2002 11:54:26 -0500
Date: Wed, 6 Feb 2002 08:54:23 -0800
From: Larry McVoy <lm@bitmover.com>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020206085423.F7674@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0202051928330.2375-100000@cesium.transmeta.com> <87g04eljw6.fsf@CERT.Uni-Stuttgart.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87g04eljw6.fsf@CERT.Uni-Stuttgart.DE>; from Weimer@CERT.Uni-Stuttgart.DE on Wed, Feb 06, 2002 at 04:17:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 04:17:29PM +0100, Florian Weimer wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > The long-range plan, and the real payoff, comes if main developers start
> > using bk too, which should make syncing a lot easier. That will take some
> > time, I suspect.
> 
> Do you think that at some point, using BitKeeper will become mandatory
> for subsystem maintainers?  ("mandatory" in the sense that
> non-BitKeeper input is dealt with in a less timely fashion, for
> example.)

If BK makes things dramatically easier for Linus, then there may be a
naturally tendency for him to look at BK patches first.  

On the other hand, he's only been using it for a week and he isn't saying
it is the best thing since sliced bread.  So it's a bit premature to
predict whether he will be using it in a month or not.  We hope so,
and we'll keep working to make you happy with it, but Linus is a harsh
judge - if BK doesn't help out, he'll kick it out the door.

And finally, almost all of the part of the back and forth over the
last week was about how to make BK better at accepting and generating
traditional patches.  You will *always* be able to send BK traditional
patches, whether Linus uses BK or not.  That was true before he used it
and his use of BK has done nothing but make it be better.  For example,
we're working out a plain text format for comments in the patch headers
so that you can comment individual changes on a per file basis in the
patch.

So the summary is that you'll always be able to do regular patches, even
if Linus continues to use BK.  There may come a time where the value of
using BK - to you - is quite high.  If not, we're back to diff&patch or
some other way.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
