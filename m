Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271201AbTHHEud (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 00:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271203AbTHHEud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 00:50:33 -0400
Received: from [66.212.224.118] ([66.212.224.118]:43282 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271201AbTHHEud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 00:50:33 -0400
Date: Fri, 8 Aug 2003 00:38:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [Bug 973] Presario kernel panic with 2.6.0
In-Reply-To: <Pine.LNX.4.44.0308072232370.13175-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0308080036310.12875@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0308072232370.13175-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Thomas Molina wrote:

> At the request of Zwane, to whom this bug is assigned, I have restested 
> with 2.6.0-test2 as well as with the mm5 patch from Andrew Morton.  I am 
> still seeing the same panic.
> 
> I believe Zwane thinks this is related to Synaptics code, but I am 
> unconvinced.  I tried the akpm patchset both with and without Synaptics 
> support and it made no difference.  

I actually wanted to confirm that it still is in -mm since that has 
changes in that area and is what would be considered the latest version of 
the driver and there would be no need to wade about in the stock tree if 
it's not there in -mm.

	Zwane

