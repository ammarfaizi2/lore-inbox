Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUBNOxI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 09:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUBNOxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 09:53:08 -0500
Received: from linux.us.dell.com ([143.166.224.162]:49792 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261744AbUBNOwx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 09:52:53 -0500
Date: Sat, 14 Feb 2004 08:52:47 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Turbo Fredriksson <turbo@bayour.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec ARO-1130CA-C
Message-ID: <20040214085247.A20697@lists.us.dell.com>
References: <87ptchzr6y.fsf@papadoc.bayour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87ptchzr6y.fsf@papadoc.bayour.com>; from turbo@bayour.com on Sat, Feb 14, 2004 at 03:11:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 03:11:33PM +0100, Turbo Fredriksson wrote:
> I have a motherboard (Intel DK440LX) with a built in SCSI controller
> (AIC-7895). To this MB there's the possibility to have a RAIDport II
> controller. I managed to get me a 'Adaptec ARO-1130CA-C' from eBay
> because I couldn't in my wildest dreams believe that Linux didn't
> support it - it's ancient!.
> It is NOT a 'AAA-113x', but I guess it's the same card with a different vendor.
> So the question is: IS it (my RAIDport II card) supported by the aacraid driver,
> in either 2.4 _or_ (if need be) the 2.6 kernels?

To the best of my knowledge, no, aacraid does not support any of the
RAIDport cards.


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
