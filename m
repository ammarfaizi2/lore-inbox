Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVAZNMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVAZNMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVAZNMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:12:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24083 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262287AbVAZNMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:12:49 -0500
Date: Wed, 26 Jan 2005 13:12:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050126131234.A30805@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de> <20050124213442.GC18933@kroah.com> <20050124214751.GA6396@infradead.org> <20050125060256.GB2061@kroah.com> <20050125195918.460f2b10.khali@linux-fr.org> <20050126003927.189640d4@zanzibar.2ka.mipt.ru> <20050125224051.190b5ff9.khali@linux-fr.org> <20050126013556.247b74bc@zanzibar.2ka.mipt.ru> <20050126101434.GA7897@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050126101434.GA7897@infradead.org>; from hch@infradead.org on Wed, Jan 26, 2005 at 10:14:34AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 10:14:34AM +0000, Christoph Hellwig wrote:
> That's simply not true.  The amount of patches submitted is extremly
> huge and the reviewers don't have time to look at everythning.
> 
> If no one replies it simply means no one has looked at it in enough
> detail to comment yet.

How do people get to know this?  Grape vines and crystal balls are
inherently unreliable.

I think that if someone overlooks the patches when they're on the mailing
lists and then complains when they're merged into the kernel, they have
very little justification when trying to make it the patch submitters
problem.  It's clearly an overall failing of the community to have enough
resources to review the patches before inclusion.

Frequently I end up with the situation where *NO* *ONE* seems interested
in my patches and I throw them at Linus anyway after months have gone by.
Maybe I'm just lucky that no one bothers to read my patches or everyone
is implicitly exstatic with them.  Nevertheless, I'm forced by the lack
of response from LKML to follow precisely the same rule - no response
implies people are happy.  In reality, not doing so would mean I'd never
get any patches merged which is unacceptable.

So, if the community has a problem with enough time to review patches,
the community must get more (good) patch reviewers.  We can't go around
blaming the patch submitters for a community failing.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
