Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWEZN5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWEZN5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 09:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWEZN5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 09:57:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13546 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750749AbWEZN5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 09:57:10 -0400
Date: Fri, 26 May 2006 06:56:47 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 02/33] radixtree: introduce __radix_tree_lookup_parent()
In-Reply-To: <348644373.06563@ustc.edu.cn>
Message-ID: <Pine.LNX.4.64.0605260656090.30694@schroedinger.engr.sgi.com>
References: <20060526113906.084341801@localhost.localdomain>
 <348644373.06563@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006, Wu Fengguang wrote:

> Introduce a general lookup function to radix tree.
> 
> - __radix_tree_lookup_parent(root, index, level)
> 	Perform partial lookup, return the @level'th parent of the slot at
> 	@index.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Would you please remove my signoff? I never reviewed this code.
