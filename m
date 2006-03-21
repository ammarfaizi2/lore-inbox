Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWCULui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWCULui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWCULui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:50:38 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:58595 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030348AbWCULuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:50:37 -0500
Date: Tue, 21 Mar 2006 13:50:31 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
In-Reply-To: <20060321032521.03a8d6de.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0603211349480.25002@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
 <20060321032521.03a8d6de.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Andrew Morton wrote:
> Problem is, after I've weathered 10000000000 convert-to-kmem_cache_zalloc
> patches, those pestiferous NUMA people are going to come along wanting
> kmem_cache_kzalloc_node().
> 
> Probably this should be designed for up-front?

I can send you one unless someone beats me to it ;-).

				Pekka
