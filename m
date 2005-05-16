Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVEPVZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVEPVZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVEPVWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:22:16 -0400
Received: from dvhart.com ([64.146.134.43]:61857 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261891AbVEPVVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:21:36 -0400
Date: Mon, 16 May 2005 14:21:28 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: coywolf@lovecn.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure in slab.c
Message-ID: <740810000.1116278488@flay>
In-Reply-To: <2cd57c90050516141533e30621@mail.gmail.com>
References: <734040000.1116277074@flay> <2cd57c90050516141533e30621@mail.gmail.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, May 17, 2005 05:15:57 +0800 Coywolf Qi Hunt <coywolf@gmail.com> wrote:

> On 5/17/05, Martin J. Bligh <mbligh@mbligh.org> wrote:
>> mm/slab.c:281: field `entry' has incomplete type
>> mm/slab.c: In function `cache_alloc_refill':
>> mm/slab.c:2497: warning: control reaches end of non-void function
>> mm/slab.c: In function `kmem_cache_alloc':
>> mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
>> mm/slab.c: In function `__kmalloc':
>> mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
>> make[1]: *** [mm/slab.o] Error 1
>> make[1]: *** Waiting for unfinished jobs....
> 
> What's your gcc version?

2.95.4 (probably ;-))

M.

