Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVGLJT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVGLJT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGLJRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:17:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49673 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261290AbVGLJPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:15:07 -0400
Date: Tue, 12 Jul 2005 10:14:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050712101459.B28413@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200507111922.04800.david-b@pacbell.net> <20050712081943.B25543@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050712081943.B25543@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jul 12, 2005 at 08:19:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 08:19:43AM +0100, Russell King wrote:
> On Mon, Jul 11, 2005 at 07:22:04PM -0700, David Brownell wrote:
> > and stop
> > whining about certain non-errors (details in the patch comments).
> 
> Please explain what the whining is (details were missing from the
> patch comments).

Exasperated sigh.

Just in case someone thinks I'm being bloody stupid and didn't read the
patch (as discovered via a private mail), I'd like the _whining_ expanded
upon (eg, what is the message) and not the reasons why.

I though it would have been obvious but it seems that it isn't...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
