Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271368AbUJVPa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271368AbUJVPa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271370AbUJVPa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:30:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S271368AbUJVPaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:30:07 -0400
Date: Fri, 22 Oct 2004 11:30:18 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <yanmin.zhang@intel.com>
Subject: Re: 2.6.9-mm1
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0410221121060.31747-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Oct 2004, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
> 
> - Lots of new patches.
> 
> - Status of as-yet-unmerged things:

Can you merge Zhang Yanmin's patch to fix hugetlb pages? The flexmap
changes prevent hugetlb pages from being allocated now for the default
process layout. link to original patch:

http://marc.theaimsgroup.com/?l=linux-scsi&m=109814866401322&w=2

thanks,

-Jason   


