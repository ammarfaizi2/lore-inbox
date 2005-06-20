Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVFTVfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVFTVfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVFTVdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:33:22 -0400
Received: from iabervon.org ([66.92.72.58]:47364 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261612AbVFTV24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:28:56 -0400
Date: Mon, 20 Jun 2005 17:26:46 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Greg KH <gregkh@suse.de>
cc: Denis Vlasenko <vda@ilport.com.ua>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.12 udev hangs at boot
In-Reply-To: <20050620164800.GA14798@suse.de>
Message-ID: <Pine.LNX.4.21.0506201723090.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Greg KH wrote:

> On Mon, Jun 20, 2005 at 01:04:10PM +0300, Denis Vlasenko wrote:
> > 
> > Greg, any plans to distribute udev and hotplug within kernel tarballs
> > so that people do not need to track such changes continuously?
> 
> Nope.  But if you use udev, you should read the announcements for new
> releases, as I did say this was required for 2.6.12, and gave everyone a
> number of weeks notice :)

Shouldn't this be listed in Changes? It looks like Changes only mentions
the existance of udev, but doesn't specify a required version, despite
there being a version requirement. (Not that I really think too many
people would think to look, but it would at least have a chance of
reaching people who look carefully at kernels but don't read the mailing
list)

	-Daniel
*This .sig left intentionally blank*

