Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271389AbTHDMKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 08:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271707AbTHDMKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 08:10:45 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:11904 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S271389AbTHDMKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 08:10:44 -0400
From: jlnance@unity.ncsu.edu
Date: Mon, 4 Aug 2003 08:10:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3
Message-ID: <20030804121043.GA1269@ncsu.edu>
References: <20030802152202.7d5a6ad1.akpm@osdl.org> <20030802223140.GA25501@outpost.ds9a.nl> <20030802164205.5cc42edc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802164205.5cc42edc.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 04:42:05PM -0700, Andrew Morton wrote:

> Bolting 64G of memory onto a 32-bit CPU is tasteless too...
> 
> We already have a bucketload of highmem hacks in the kernel, and they are
> not sufficient for some people.  We have several more (large) highmem hacks
> being proposed.

Do you see us removing the other highmem hacks if we add the 4G/4G patch?

Thanks,

Jim
