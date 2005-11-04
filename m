Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbVKDPXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbVKDPXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVKDPXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:23:05 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:29378 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964936AbVKDPXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:23:03 -0500
Subject: Re: 3D video card recommendations
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5bdc1c8b0511040710q4a4ce3eend6edc2b4027e33b0@mail.gmail.com>
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <5bdc1c8b0511040710q4a4ce3eend6edc2b4027e33b0@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 04 Nov 2005 10:22:59 -0500
Message-Id: <1131117779.14381.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 07:10 -0800, Mark Knecht wrote:
> On 11/4/05, Steven Rostedt <rostedt@goodmis.org> wrote:

> > I'm looking at the ATI Radeons.
> >
> > Any recommendations? (links to info would also be nice ;-)
> >
> > Thanks,
> >
> > -- Steve
> 
> Not a recommendation. Just a point to be aware of. The ATI Radeons, to
> get the best acceleration, seem to require that you use the ATI closed
> source drivers. Currently I haven't found an ATI closed source driver
> that supports 2.6.14. so I'm forced to use the Xorg radeon driver. I
> have no idea if this is very good. I don't think so as my glxgear
> numbers are pretty low. Much lower than the ATI driver running on
> 2.6.13-X.

I'm sure ATI will come out with a proprietary driver for 2.6.14.  I just
want some 3D accel for working with -rt.  If I want to play a game, I'll
just back out to 2.6.13 and use the ATI binary driver.  But right now
with NVidia, it is either -rt with no accel, or accel with no -rt.

Thanks,

-- Steve


