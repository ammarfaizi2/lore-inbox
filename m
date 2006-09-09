Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWIIDNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWIIDNR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWIIDNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:13:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51330 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932102AbWIIDNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:13:15 -0400
Date: Fri, 8 Sep 2006 20:13:03 -0700
From: Greg KH <gregkh@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17.12
Message-ID: <20060909031303.GB17712@suse.de>
References: <20060908220741.GA26950@kroah.com> <45022333.6030605@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45022333.6030605@eyal.emu.id.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 12:13:07PM +1000, Eyal Lebedinsky wrote:
> Greg KH wrote:
> > We (the -stable team) are announcing the release of the 2.6.17.12 kernel.
> 
> A quick report, will investigate later:
> 
> WARNING: /lib/modules/2.6.17.12/kernel/drivers/md/dm-mod.ko needs unknown symbol idr_replace
> 
> I did not change my config throughout the series.

Can you send me your .config?

thanks,

greg k-h
