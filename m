Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbUKTOVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUKTOVL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 09:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbUKTOVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 09:21:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42504 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262930AbUKTOVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 09:21:07 -0500
Date: Sat, 20 Nov 2004 14:21:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Fulghum <paulkf@microgate.com>
Subject: Re: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending Config-Requests"
Message-ID: <20041120142104.D13550@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Paul Fulghum <paulkf@microgate.com>
References: <20041019131240.A20243@flint.arm.linux.org.uk> <20041120131159.C13550@flint.arm.linux.org.uk> <1100954046.11951.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1100954046.11951.0.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Sat, Nov 20, 2004 at 12:34:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 12:34:07PM +0000, Alan Cox wrote:
> On Sad, 2004-11-20 at 13:11, Russell King wrote:
> > So, what can I do with this bug?  Just close or reject it, or what?
> > Maybe Alan or Paul would like to assign this bug to themselves?
> > 
> 
> I thought that was fixed in 10rc and 2.6.9-ac

Maybe, I have no idea - no one updated the bug, and I'd just like to
get rid of it one way or the other.

I'm tempted to reject it with a comment "status unknown, please resubmit
if it remains a problem" - which kind of makes a mockery of bug tracking
systems.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
