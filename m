Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVHQEQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVHQEQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 00:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVHQEQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 00:16:39 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27852 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750801AbVHQEQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 00:16:38 -0400
Subject: Re: [PATCH] [Fwd: Console locking and blanking]
From: Steven Rostedt <rostedt@goodmis.org>
To: abonilla@linuxwireless.org
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1124250948.4855.93.camel@localhost.localdomain>
References: <1124242875.8848.10.camel@gaston>
	 <1124249381.8848.19.camel@gaston>
	 <1124250271.5764.76.camel@localhost.localdomain>
	 <1124250948.4855.93.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 00:16:26 -0400
Message-Id: <1124252186.5764.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 21:55 -0600, Alejandro Bonilla Beeche wrote:
> On Tue, 2005-08-16 at 23:44 -0400, Steven Rostedt wrote:
> > On Wed, 2005-08-17 at 13:29 +1000, Benjamin Herrenschmidt wrote:
> > > On Wed, 2005-08-17 at 11:41 +1000, Benjamin Herrenschmidt wrote:
> > > 
> > > > (I'm blind and I use a braille display. I use those functions to blank 
> > > > my laptop's screen so people don't read it, and hopefully to conserve 
> > > > power.)
> > 
> > At the OLS I learned that the backlight of a laptop (when the screen is
> > black, but still glows) actually spends more wattage than when the
> > screen is lit.  So, unless you actually turn the laptop display off,
> > switching it to black will actually burn the battery quicker.
> 
> This sounds stupid. Who told you this? The actual brightness is the one
> that consumes the most battery.
> 
> Seriously, who told you such thing?
> 

It was one of the speakers during the presentation.  He seemed to know
what he was talking about, in fact, I was caught so off guard by the
statement, I got up and ask him the question again. "Did you say that
the backlight of the laptop takes up more energy than when it is on?"
and he replied "yes"!

I rememeber this being in room C (could be wrong, I went to so many
sessions).  Looking at the program, it could have been "Linux Power
Management" by Patrick Mochel. But I honestly don't remember which
session it was. (I'm CCing him to see if he can clear things up :-)

-- Steve


