Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWCBU51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWCBU51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWCBU51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:57:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27665 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932291AbWCBU51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:57:27 -0500
Date: Thu, 2 Mar 2006 20:57:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>, Dave Miller <davem@redhat.com>,
       axboe@suse.de, bzolnier@gmail.com, james.steward@dynamicratings.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, mattjreimer@gmail.com
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
Message-ID: <20060302205704.GI28895@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Tejun Heo <htejun@gmail.com>, Dave Miller <davem@redhat.com>,
	axboe@suse.de, bzolnier@gmail.com, james.steward@dynamicratings.com,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	mattjreimer@gmail.com
References: <11371658562541-git-send-email-htejun@gmail.com> <1137167419.3365.5.camel@mulgrave> <20060113182035.GC25849@flint.arm.linux.org.uk> <1137177324.3365.67.camel@mulgrave> <20060113190613.GD25849@flint.arm.linux.org.uk> <20060222082732.GA24320@htj.dyndns.org> <1141325189.3238.37.camel@mulgrave.il.steeleye.com> <20060302203039.GH28895@flint.arm.linux.org.uk> <1141332239.3238.59.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141332239.3238.59.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 02:43:59PM -0600, James Bottomley wrote:
> On Thu, 2006-03-02 at 20:30 +0000, Russell King wrote:
> > Therefore, message I'm getting from you is that we are not allowed to
> > have an ARM system which can possibly work correctly with PIO.
> > 
> > As a result, I have no further interest in trying to resolve this issue,
> > period.  ARM people will just have to accept that PIO mode IDE drivers
> > just will not be an option.
> 
> Could you actually address the argument instead of getting all huffy?

I'm sorry, I've addressed the argument, and as far as I'm concerned,
there's nothing more I have to usefully contribute to this thread.
Sorry, you've worn me out, you've won.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
