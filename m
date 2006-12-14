Return-Path: <linux-kernel-owner+w=401wt.eu-S964942AbWLNWpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWLNWpm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWLNWpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:45:42 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:35141
	"EHLO vs166246.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964942AbWLNWpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:45:41 -0500
From: Michael Buesch <mb@bu3sch.de>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Thu, 14 Dec 2006 23:45:05 +0100
User-Agent: KMail/1.9.5
References: <20061214003246.GA12162@suse.de> <200612142326.43295.mb@bu3sch.de> <21d7e9970612141439s9ff4652tddd0983d19daeed3@mail.gmail.com>
In-Reply-To: <21d7e9970612141439s9ff4652tddd0983d19daeed3@mail.gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, "Rik van Riel" <riel@redhat.com>,
       "Greg KH" <gregkh@suse.de>, "Jonathan Corbet" <corbet@lwn.net>,
       "Andrew Morton" <akpm@osdl.org>, "Martin Bligh" <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "Jeff Garzik" <jeff@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612142345.06013.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 23:39, Dave Airlie wrote:
> > >
> > > It'll get in when the developers feel it is at a stage where it can be
> > > supported, at the moment (I'm not speaking for all the nouveau team
> > > only my own opinion) the API isn't stable and putting it into the
> > > kernel only means we've declared the API supportable, I know in theory
> > > marking it EXPERIMENTAL might work, in practice it will just cause us
> > > headaches at this stage, there isn't enough knowledgeable developers
> > > working on it both support users and continue development at a decent
> > > rate, so mainly ppl are concentrating on development until it can at
> > > least play Q3, and for me dualhead on my G5 :-)
> >
> > To what degree does it work on the G5?
> > Can we already drive a desktop system with it?
> > I'd like to play around with this on my Quad.
> >
> 
> 2D worked the last time I tested it and fixed up all the problems, it
> is slightly faster than nv, but may be more unstable, still only
> single head... 3D even on x86 doesn't work yet without pre-loading
> nvidia to set the hardware up correctly.. but it's coming along....
> there are summary updates posted ~weekly on the nouveau wiki....

Ok, that's nice to hear. :)
Can't be much more pain than nv, heh.
And as I only have singlehead, anyway, I'll give it a try.

-- 
Greetings Michael.
