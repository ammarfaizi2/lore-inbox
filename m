Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWHPPI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWHPPI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWHPPI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:08:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34688 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751197AbWHPPI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:08:26 -0400
Date: Wed, 16 Aug 2006 08:08:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Matt Mackall <mpm@selenic.com>
cc: Andi Kleen <ak@muc.de>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
In-Reply-To: <20060816084119.GW6908@waste.org>
Message-ID: <Pine.LNX.4.64.0608160807120.16619@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816095254.14ac872c.ak@muc.de> <20060816084119.GW6908@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Matt Mackall wrote:

> The approach we thought was most promising started with splitting the
> dcache into directory and leaf entries.

Dipankar later told me that they have tried that approch and it was 
of no benefit.

