Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbTKMM5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 07:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTKMM5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 07:57:44 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:48288 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264074AbTKMM5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 07:57:43 -0500
Date: Thu, 13 Nov 2003 07:57:39 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Dax Kelson <dax@gurulabs.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: List of SCO files
In-Reply-To: <1068691791.13135.41.camel@gaston>
Message-ID: <Pine.LNX.4.44.0311130756340.22062-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Benjamin Herrenschmidt wrote:

> Or just include/asm-m68k/spinlock.h :)

> #ifndef __M68K_SPINLOCK_H
> #define __M68K_SPINLOCK_H
> #error "m68k doesn't do SMP yet"
> #endif

I wonder if that reflects the state SCO's OSes are in,
with respect to the technologies they claim that IBM
misappropriated ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

