Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWFNFh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWFNFh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWFNFh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:37:58 -0400
Received: from silver.veritas.com ([143.127.12.111]:47746 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964886AbWFNFh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:37:57 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,129,1149490800"; 
   d="scan'208"; a="39193114:sNHT24897532"
Date: Wed, 14 Jun 2006 06:37:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: zoned vm counters: per zone counter functionality
In-Reply-To: <448F64A0.9090705@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0606140636130.780@blonde.wat.veritas.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
 <20060612211255.20862.39044.sendpatchset@schroedinger.engr.sgi.com>
 <448E4F05.9040804@yahoo.com.au> <Pine.LNX.4.64.0606130854480.29796@schroedinger.engr.sgi.com>
 <448F64A0.9090705@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Jun 2006 05:37:57.0457 (UTC) FILETIME=[B0F6A410:01C68F74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006, Nick Piggin wrote:
> 
> Hmm, then NR_ANON would become VM_ZONE_STAT_NR_ANON? That might be a bit
> long for your tastes, maybe the prefix could be hidden by "clever" macros?

Don't even begin to think of "clever" macros.

Hugh
