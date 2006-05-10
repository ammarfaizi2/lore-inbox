Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWEJRm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWEJRm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWEJRm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:42:29 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:27527 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932301AbWEJRm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:42:28 -0400
Date: Wed, 10 May 2006 20:42:23 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alloc_memory_early() routines
In-Reply-To: <20060510161604.GC3198@w-mikek2.ibm.com>
Message-ID: <Pine.LNX.4.58.0605102041550.9813@sbz-30.cs.Helsinki.FI>
References: <20060509053512.GA20073@monkey.ibm.com> <20060508224952.0b43d0fd.akpm@osdl.org>
 <20060509210722.GD3168@w-mikek2.ibm.com> <84144f020605100009i74824233ie6feaf6fd2d9055f@mail.gmail.com>
 <Pine.LNX.4.64.0605100011090.3040@schroedinger.engr.sgi.com>
 <20060510161604.GC3198@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Mike Kravetz wrote:
> I like the 'slab_is_available()' check.  How about if we simply add
> this routine and let the people doing the allocation determine what
> allocator to use?

I'm fine with that.

				Pekka
