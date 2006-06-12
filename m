Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752092AbWFLP4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbWFLP4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbWFLP4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:56:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53519 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752092AbWFLP4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:56:02 -0400
Date: Mon, 12 Jun 2006 16:55:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Neil Brown <neilb@suse.de>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060612155552.GA322@flint.arm.linux.org.uk>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	Matti Aarnio <matti.aarnio@zmailer.org>, zwane@holomorphy.com,
	linux-kernel@vger.kernel.org
References: <20060610222734.GZ27502@mea-ext.zmailer.org> <20060611072223.GA16150@flint.arm.linux.org.uk> <20060612083239.GA27502@mea-ext.zmailer.org> <20060612084012.GA7291@flint.arm.linux.org.uk> <17549.14978.52678.562114@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17549.14978.52678.562114@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 07:57:22PM +1000, Neil Brown wrote:
> On Monday June 12, rmk+lkml@arm.linux.org.uk wrote:
> > On Mon, Jun 12, 2006 at 11:32:39AM +0300, Matti Aarnio wrote:
> > > SPF is application level version of this type of source sanity
> > > enforcement, and all that I intend to do is to publish that TXT
> > > entry for VGER.  Analyzing SPF data in incoming SMTP reception
> > > is a thing that I leave for latter phase  (how much latter,
> > > I can't say yet.)
> > 
> > In which case I have no option but to ask - Zwane, please stop using
> > my systems to forward your lkml email - Matti's proposed change will
> > potentially break that setup.
> 
> Of course you do have other options.

Since you haven't read my original reply to Matti, your comments aren't
appropriate for me since you don't know the full story.

However, I will point out that I'm at liberty to choose any option I
deem to be appropriate, for whatever reasons I feel appropriate.  In
this situation, I feel that withdrawing from providing mail forwarding
facilities is most appropriate.

I've been thinking about withdrawing that for some time for other
reasons - the SPF argument has provided another, and the final reason
to make it happen.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
