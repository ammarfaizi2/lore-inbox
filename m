Return-Path: <linux-kernel-owner+w=401wt.eu-S1750793AbXAEWNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbXAEWNe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 17:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbXAEWNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 17:13:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41564 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750793AbXAEWNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 17:13:33 -0500
Date: Fri, 5 Jan 2007 14:12:58 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       apw@shadowen.org, hch@lst.de, manfred@colorfullife.com,
       christoph@lameter.com, pj@sgi.com
Subject: Re: [PATCH] slab: cache alloc cleanups
In-Reply-To: <20070105115057.69d5ff11.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701051412300.29810@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0701051345040.20220@sbz-30.cs.Helsinki.FI>
 <20070105115057.69d5ff11.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Andrew Morton wrote:

> Does this actually clean things up, or does it randomly move things around
> while carefully retaining existing obscurity?  Not sure..

Looks like a good cleanup to me.
