Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbTGIE6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 00:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbTGIE6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 00:58:55 -0400
Received: from franka.aracnet.com ([216.99.193.44]:46721 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265661AbTGIE6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 00:58:54 -0400
Date: Tue, 08 Jul 2003 22:13:12 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <55580000.1057727591@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i'm pleased to announce the first public release of the "4GB/4GB VM split"
> patch, for the 2.5.74 Linux kernel:
> 
>    http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8

I presume this was for -bk something as it applies clean to -bk6, but not
virgin. 

However, it crashes before console_init on NUMA ;-( I'll shove early printk
in there later.

M.

