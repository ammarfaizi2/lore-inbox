Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVBWJhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVBWJhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 04:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVBWJhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 04:37:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:61086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261439AbVBWJhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 04:37:08 -0500
Date: Wed, 23 Feb 2005 01:36:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: kaigai@ak.jp.nec.com, jlan@sgi.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, tim@physik3.uni-rostock.de,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com, elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050223013606.4becfa04.akpm@osdl.org>
In-Reply-To: <1109151006.1738.119.camel@frecb000711.frec.bull.fr>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
	<20050222232002.4d934465.akpm@osdl.org>
	<1109147623.1738.91.camel@frecb000711.frec.bull.fr>
	<20050223005135.3d8ce2f3.akpm@osdl.org>
	<1109151006.1738.119.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
>   I will run benchmarks found at http://bulk.fefe.de/scalability/ to see
>  how the fork connector impacts on the kernel.

The lmbench fork microbenchmark would suffice.

>    All stuff that was previously done in kernel space and provided by the
>  2.6.8.1 ELSA patch has been moved in the ELSA user space daemon called
>  "jobd".

Excellent.  Will it work?
