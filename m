Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVASLJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVASLJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVASLJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:09:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261683AbVASLJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:09:07 -0500
Date: Wed, 19 Jan 2005 11:09:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adam Radford <aradford@amcc.com>
Cc: Peter Daum <gator@cs.tu-berlin.de>, linux-kernel@vger.kernel.org
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
Message-ID: <20050119110902.GA12903@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adam Radford <aradford@amcc.com>,
	Peter Daum <gator@cs.tu-berlin.de>, linux-kernel@vger.kernel.org
References: <20050110132133.GA12360@infradead.org> <Pine.LNX.4.30.0501101452590.14606-100000@swamp.bayern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0501101452590.14606-100000@swamp.bayern.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > It looks like in the 3ware driver the procfs entry "/proc/scsi/3w-xxxx"
> > > has been removed (or actually moved to sysfs).
> > > Unfortunately, this breaks all the (binary only )-: tools provided by
> > > 3ware, which are indispensable for system maintenance.
> >
> > The change came from the driver maintainer at 3ware.  Get the updated
> > tools from their website.
> 
> Which website do you mean? The programs in the download section of
> "www.3ware.com" are just the ones that don't work anymore.

It's there just a little hidden.  Adam, any chance the new managment tools
could be placed more promimently on the website?

