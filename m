Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUKIQdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUKIQdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUKIQdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:33:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:3300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261576AbUKIQ2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:28:40 -0500
Date: Tue, 9 Nov 2004 08:27:30 -0800
From: Greg KH <greg@kroah.com>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ub vs. usb-storage
Message-ID: <20041109162730.GA2439@kroah.com>
References: <4190AEFC.7060708@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4190AEFC.7060708@lbsd.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 11:50:20AM +0000, Nigel Kukard wrote:
> Hi,
> 
> Using kernel 2.6.9 bk7 and the UB driver for mass-storage I seem to see 
> spikes on the load-avg of over 700. There is also times of extreme 
> responsiveness deficiency.
> 
> Using the usb_storage driver seems to fix the problem. Is UB only meant 
>  for low performance situations?

For now, yes.

thanks,

greg k-h
