Return-Path: <linux-kernel-owner+w=401wt.eu-S932091AbXAOH0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbXAOH0n (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 02:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbXAOH0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 02:26:43 -0500
Received: from mx1.suse.de ([195.135.220.2]:38221 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091AbXAOH0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 02:26:43 -0500
Date: Sun, 14 Jan 2007 23:25:54 -0800
From: Greg KH <greg@kroah.com>
To: David Miller <davem@davemloft.net>
Cc: dlstevens@us.ibm.com, dsd@gentoo.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] 2.6.19.2 regression introduced by "IPV4/IPV6: Fix inet{, 6} device initialization order."
Message-ID: <20070115072554.GA16969@kroah.com>
References: <45AAF3AC.3070600@gentoo.org> <OF0ECEC103.470302BB-ON88257264.00142A49-88257264.0014DC27@us.ibm.com> <20070114.213008.74745274.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114.213008.74745274.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 09:30:08PM -0800, David Miller wrote:
> From: David Stevens <dlstevens@us.ibm.com>
> Date: Sun, 14 Jan 2007 19:47:49 -0800
> 
> > I think it's better to add the fix than withdraw this patch, since
> > the original bug is a crash.
> 
> I completely agree.

Great, can someone forward the patch to us?

thanks,

greg k-h
