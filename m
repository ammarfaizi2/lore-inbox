Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVELVtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVELVtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVELVtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:49:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17038 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262145AbVELVtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:49:18 -0400
Date: Thu, 12 May 2005 16:49:02 -0500
From: Robin Holt <holt@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       shai@scalex86.org
Subject: Re: NUMA aware slab allocator V2
Message-ID: <20050512214902.GA18835@lnx-holt.americas.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

Can you let me know when this is in so I can modify the ia64 pgalloc.h
to not use the quicklists any longer?

Thanks,
Robin
