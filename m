Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285410AbRLSS5g>; Wed, 19 Dec 2001 13:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282495AbRLSS5Q>; Wed, 19 Dec 2001 13:57:16 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:43466 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282502AbRLSS5J>; Wed, 19 Dec 2001 13:57:09 -0500
Date: Wed, 19 Dec 2001 13:57:08 -0500
From: Ben LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: aio
Message-ID: <20011219135708.A12608@devserv.devel.redhat.com>
In-Reply-To: <E16Gjuw-0000UT-00@starship.berlin> <Pine.LNX.4.33.0112190859050.1872-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112190859050.1872-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 19, 2001 at 09:01:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 09:01:59AM -0800, Linus Torvalds wrote:
> 
> On Wed, 19 Dec 2001, Daniel Phillips wrote:
> >
> > It's AIO we're talking about, right?  AIO is interesting to quite a few
> > people.  I'd read the thread.  I'd also read any background material that Ben
> > would be so kind as to supply.
> 
> Case closed.
> 
> Dan didn't even _know_ of the patches.

He doesn't read l-k apparently.

> Ben: end of discussion. I will _not_ apply any patches for aio if they
> aren't openly discussed. We're not microsoft, and we're not Sun. We're
> "Open Source", not "cram things down peoples throat and spring new
> features on them as a fait accompli".

Discuss them then to your heart's content.  I've posted announcements to 
both l-k and linux-aio which are both on marc.theaimsgroup.com if you're 
too lazy to get your IS to add a new list yo the internal news gateway.

> The ghost of "binary compatibility" is not an issue - if Ben or anytbody
> else finds a flaw with the design, it's a hell of a lot better to have
> that flaw fixed _before_ it's part of my kernel rather than afterwards.

Thanks for the useful feedback on the userland interface then.  Evidently 
nobody cares within the community about improving functionality on a 
reasonable timescale.  If this doesn't change soon, Linux is doomed.

		-ben
