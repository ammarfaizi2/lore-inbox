Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136211AbRECIIj>; Thu, 3 May 2001 04:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136213AbRECIIa>; Thu, 3 May 2001 04:08:30 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:57606 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136211AbRECIIN>;
	Thu, 3 May 2001 04:08:13 -0400
Date: Thu, 3 May 2001 04:09:03 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
Message-ID: <20010503040903.A28363@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503034755.A27693@thyrsus.com> <3AF110CB.6074C036@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF110CB.6074C036@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, May 03, 2001 at 04:03:23AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> "Eric S. Raymond" wrote:
> > OK, so you want CML2's "make oldconfig" to do something more graceful than
> > simply say "Foo! You violated this constraint! Go fix it!"
> [...]
> > Have I got the point across yet?  There are *no* good solutions 
> > to this problem.  There aren't even any clean ways to separate 
> > easy cases from hard ones. 
> 
> No good solutions?  Then how come I use "make oldconfig" every day...

You fix broken configs by hand.  That's what you'll do in the new
system, too.
 
> IMHO "make oldconfig" must stay.

There was never any risk it would go away.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Everything you know is wrong.  But some of it is a useful first approximation.
