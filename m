Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVKJAMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVKJAMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVKJAMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:12:32 -0500
Received: from holomorphy.com ([66.93.40.71]:47820 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1751090AbVKJAMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:12:31 -0500
Date: Wed, 9 Nov 2005 16:11:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adam Litke <agl@us.ibm.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       David Gibson <david@gibson.dropbear.id.au>, hugh@veritas.com,
       rohit.seth@intel.com, kenneth.w.chen@intel.com
Subject: Re: [PATCH 2/4] Hugetlb: Rename find_lock_page to find_or_alloc_huge_page
Message-ID: <20051110001146.GL29402@holomorphy.com>
References: <1131578925.28383.9.camel@localhost.localdomain> <1131579472.28383.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131579472.28383.20.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 05:37:52PM -0600, Adam Litke wrote:
> Hugetlb: Rename find_lock_page to find_or_alloc_huge_page

> On Wed, 2005-10-26 at 12:00 +1000, David Gibson wrote:
> - find_lock_huge_page() isn't a great name, since it does extra things
>   not analagous to find_lock_page().  Rename it
>   find_or_alloc_huge_page() which is closer to the mark.
> Original post by David Gibson <david@gibson.dropbear.id.au>
> Version 2: Wed 9 Nov 2005
> 	Split into a separate patch
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Adam Litke <agl@us.ibm.com>

Also innocuous.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
