Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbUKWB4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUKWB4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUKWBxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:53:40 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:11239 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261171AbUKVWv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:51:28 -0500
Date: Mon, 22 Nov 2004 14:51:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
In-Reply-To: <20041122224333.GI2714@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0411221450500.22895@schroedinger.engr.sgi.com>
References: <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au>
 <20041119225701.0279f846.akpm@osdl.org> <419EEE7F.3070509@yahoo.com.au>
 <1834180000.1100969975@[10.10.2.4]> <Pine.LNX.4.58.0411200911540.20993@ppc970.osdl.org>
 <20041120190818.GX2714@holomorphy.com> <Pine.LNX.4.58.0411201112200.20993@ppc970.osdl.org>
 <20041120193325.GZ2714@holomorphy.com> <Pine.LNX.4.58.0411220932270.22144@schroedinger.engr.sgi.com>
 <20041122224333.GI2714@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, William Lee Irwin III wrote:

> The specific patches you compared matter a great deal as there are
> implementation blunders (e.g. poor placement of counters relative to
> ->mmap_sem) that can ruin the results. URL's to the specific patches
> would rule out that source of error.

I mentioned V4 of this patch which was posted to lkml. A simple search
should get you there.
