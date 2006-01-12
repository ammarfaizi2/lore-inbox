Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWALGTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWALGTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWALGTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:19:46 -0500
Received: from waste.org ([64.81.244.121]:20921 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932684AbWALGTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:19:46 -0500
Date: Thu, 12 Jan 2006 00:11:21 -0600
From: Matt Mackall <mpm@selenic.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
Subject: Re: [PATCH 2.6.15] do_truncate() call fix in tiny-shmem.c
Message-ID: <20060112061121.GB3356@waste.org>
References: <20060111125418.13276.29099.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111125418.13276.29099.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 12:54:18PM +0000, Catalin Marinas wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> This is a simple patch to adapt tiny-shmem.c to the new do_truncate()
> prototype.

It's probably right, and Hugh came up with the same thing. I'm on a
a random hillside in rural New Zealand, so I haven't properly looked
it over, but I'll give it a tentative ACK to get things going.
 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
