Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVIHQZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVIHQZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVIHQZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:25:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51729 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964892AbVIHQZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:25:44 -0400
Date: Thu, 8 Sep 2005 17:25:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Miller <davem@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Serial maintainership
Message-ID: <20050908172537.F5661@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Dave Miller <davem@redhat.com>,
	Andrew Morton <akpm@osdl.org>
References: <20050908165256.D5661@flint.arm.linux.org.uk> <1126197523.19834.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126197523.19834.49.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Thu, Sep 08, 2005 at 05:38:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:38:43PM +0100, Alan Cox wrote:
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

Well, it appears that we're fast approaching meltdown in kernel
land - patches are being applied despite maintainers objection,
maintainers are not being copied with changes in their area, etc.

I might mind less with the occasional slip up if it was occasional,
but it doesn't appear to be anymore - maybe not from my perspective.

This morning Andi Kleen stated:

 "normally he (akpm) asks you before finally sending them off -
  then you can complain again"

I don't appear to be asked by akpm - patches from -mm are sent
to Linus CC'd me, and that occurs during the night.  Come the
morning, they're in Linus tree so unless one is awake reading
email 24 hours a day, it's impossible to "complain again".

Is there a concerted effort to maintainers?  It certainly seems
so from my perspective.

---
Paranoia, n.
   1. A psychotic disorder characterized by delusions of persecution
      with or without grandeur, often strenuously defended with apparent
      logic and reason.
   2. Extreme, irrational distrust of others.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
