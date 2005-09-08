Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVIHQ2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVIHQ2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVIHQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:28:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932544AbVIHQ2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:28:31 -0400
Date: Thu, 8 Sep 2005 09:27:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Dave Miller <davem@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Serial maintainership
In-Reply-To: <1126197523.19834.49.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509080922230.3208@g5.osdl.org>
References: <20050908165256.D5661@flint.arm.linux.org.uk>
 <1126197523.19834.49.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Sep 2005, Alan Cox wrote:
>
> On Iau, 2005-09-08 at 16:52 +0100, Russell King wrote:
> > I notice DaveM's taken over serial maintainership.  Please arrange for
> > serial patches to be sent to davem in future, thanks.  (All ARM serial
> > drivers are broken as of Tuesday.)
> > 
> > I might take a different view if I at least had a curtious CC: of the
> > patch, which I had already asked akpm to reject.
> > 
> > Thanks.  That's another subsystem I don't have to care about anymore.
> 
> Please remember to send Linus a patch updating MAINTAINERS if so.

Guys, stop being stupid about things. I already sent rmk an email in 
private. And Alan, there's absolutely no point in making things even 
worse.

Mistakes happen, and the way you fix them is not to pull a tantrum, but 
tell people that they are idiots and they broke something, and get them to 
fix it instead.

You don't have to be polite about it, and swearing is fine. So instead of
saying "I don't want to play any more because Davem made a mistake", say
something like "Davem is a f*cking clueless moron, here's what he did and
here's why it's wrong".

Notice? In both cases you get to vent your unhappiness. In the second
case, you make the person who made a mistake look bad. But in the first
case, it's just yourself that looks bad.

		Linus
