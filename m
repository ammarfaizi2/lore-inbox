Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282175AbRKWQUd>; Fri, 23 Nov 2001 11:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282174AbRKWQUX>; Fri, 23 Nov 2001 11:20:23 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:43913 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S282173AbRKWQUK>; Fri, 23 Nov 2001 11:20:10 -0500
Date: Fri, 23 Nov 2001 11:20:03 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.15-pre9
Message-ID: <20011123112003.B27707@alcove.wittsend.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Anuradha Ratnaweera <anuradha@gnu.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011122134700.A4966@bee.lk> <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 10:52:03AM -0800, Linus Torvalds wrote:

> On Thu, 22 Nov 2001, Anuradha Ratnaweera wrote:
> >
> > On Wed, Nov 21, 2001 at 10:44:30PM -0800, Linus Torvalds wrote:
> > >
> > > I think I'm ready to hand this over to Marcelo.
> >
> > Aren't you going to include Tim Schmielau's patch to handle uptime larger than
> > 497 days?  It is a cool feature we always liked to have.

> Quite frankly, right now I'm in "handle only bugs that can crash the
> system mode". Anything that takes 497 days to see is fairly low on my
> priority list. My highest priority, in fact, is to get 2.4.15 out without
> any embarrassment.

	Embarrasments like having the modules install into directories
like /lib/modules/2.4.15-greased-turkey or vmlinuz installed to an
image /boot/vmlinuz-2.4.15-greased-turkey?  Those sorts of embarrasments?
Or was that just a last shot to see if we were still awake in 2.4?

	[...]

> 		Linus

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
