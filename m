Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUKRC4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUKRC4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUKRC4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:56:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:51674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbUKRC42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:56:28 -0500
Date: Wed, 17 Nov 2004 18:56:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Ian.Pratt@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 1] Xen core patch : ptep_establish_new
Message-Id: <20041117185604.216b9a6a.akpm@osdl.org>
In-Reply-To: <E1CUZVj-00052O-00@mta1.cl.cam.ac.uk>
References: <E1CUZVj-00052O-00@mta1.cl.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt <Ian.Pratt@cl.cam.ac.uk> wrote:
>
> diff -Nurp pristine-linux-2.6.9/include/asm-generic/pgtable.h tmp-linux-2.6.9-xen.patch/include/asm-generic/pgtable.h
>  --- pristine-linux-2.6.9/include/asm-generic/pgtable.h	2004-10-18 22:53:46.000000000 +0100
>  +++ tmp-linux-2.6.9-xen.patch/include/asm-generic/pgtable.h	2004-11-04 23:27:24.000000000 +0000
>  @@ -42,6 +42,13 @@ do {				  					  \
>   } while (0)
>   #endif

This patch is mangled and doesn't apply.
