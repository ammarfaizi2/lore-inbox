Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVFWIsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVFWIsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVFWIlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:41:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9996 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262288AbVFWIKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:10:55 -0400
Date: Thu, 23 Jun 2005 09:10:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, kernel@mikebell.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623091034.A26836@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	kernel@mikebell.org
References: <200506222108.50905.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506222108.50905.david-b@pacbell.net>; from david-b@pacbell.net on Wed, Jun 22, 2005 at 09:08:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 09:08:50PM -0700, David Brownell wrote:
> I'd agree that embedded setups are the ones that have been slowest to
> switch over, for various reasons.  One of them is that many LKML folk
> ignore embedded systems issues; "just PC class or better".

I don't think that's a fair comment - however I never read any of those
udev/devfs flamewars.  As the lead developer of an embedded architecture,
I find that many people here do not take that attitude.

More the problem is that many embedded folk aren't here to air their
*technical* arguments because they can't keep up with the lkml traffic
level.

Consequently, lkml folk don't get the feedback from embedded folk, and
hence probably why udev doesn't/didn't work with ash.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
