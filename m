Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWALGrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWALGrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWALGrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:47:13 -0500
Received: from gold.veritas.com ([143.127.12.110]:47700 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932690AbWALGrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:47:13 -0500
Date: Thu, 12 Jan 2006 06:47:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Matt Mackall <mpm@selenic.com>
cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 2.6.15] do_truncate() call fix in tiny-shmem.c
In-Reply-To: <20060112061121.GB3356@waste.org>
Message-ID: <Pine.LNX.4.61.0601120646370.5207@goblin.wat.veritas.com>
References: <20060111125418.13276.29099.stgit@localhost.localdomain>
 <20060112061121.GB3356@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Jan 2006 06:47:12.0943 (UTC) FILETIME=[049FBBF0:01C61744]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006, Matt Mackall wrote:
> On Wed, Jan 11, 2006 at 12:54:18PM +0000, Catalin Marinas wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > This is a simple patch to adapt tiny-shmem.c to the new do_truncate()
> > prototype.
> 
> It's probably right, and Hugh came up with the same thing. I'm on a
> a random hillside in rural New Zealand, so I haven't properly looked
> it over, but I'll give it a tentative ACK to get things going.
>  
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Acked-by: Matt Mackall <mpm@selenic.com>

Acked-by: Hugh Dickins <hugh@veritas.com>
