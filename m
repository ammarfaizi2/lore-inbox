Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946035AbWBORJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946035AbWBORJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946033AbWBORJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:09:43 -0500
Received: from [194.90.237.34] ([194.90.237.34]:10089 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1946030AbWBORJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:09:41 -0500
Date: Wed, 15 Feb 2006 19:11:01 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] add asm-generic/mman.h
Message-ID: <20060215171101.GF12974@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060215151649.GA12090@mellanox.co.il> <Pine.LNX.4.64.0602150857490.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602150857490.3691@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 15 Feb 2006 17:11:27.0500 (UTC) FILETIME=[DB5314C0:01C63252]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> You've changed MS_INVALIDATE from 2 to 4 here.

It was just a typo, sorry.
I've just resent it with MS_INVALIDATE fixed to 4.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
