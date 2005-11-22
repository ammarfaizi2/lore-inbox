Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVKVRu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVKVRu3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVKVRu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:50:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:18833 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965035AbVKVRu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:50:29 -0500
Date: Tue, 22 Nov 2005 09:50:17 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122175017.GA10783@kroah.com>
References: <20051121225303.GA19212@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121225303.GA19212@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 02:53:03PM -0800, Greg KH wrote:
> Any objections to this?
> 
> thanks,
> 
> greg k-h
> 
> ---------------------
> 
> Subject: PCI: fix up the exported symbols to be the proper license.
> 
> 
> Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

And just to set the record straight, for those that want to read things
into this proposal, this patch is the creation of my personal opinion,
and I do not speak for, nor represent my employer, or anyone else.

This patch was to get people who are relying on binary drivers to think
about the risk they are taking when they do so.  It is not intended as
legal advice, but a thought exercise only.

And if anyone thinks I would actually apply such a patch directly as-is,
they are wrong.  I would not deserve to be the PCI maintainer if I did
so.

thanks,

greg k-h
