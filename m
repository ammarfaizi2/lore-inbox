Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUGIDh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUGIDh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 23:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUGIDh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 23:37:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:44261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263743AbUGIDhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 23:37:24 -0400
Date: Thu, 8 Jul 2004 20:36:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Shai Fultheim" <shai@scalex86.org>
Cc: linux-kernel@vger.kernel.org, mort@wildopensource.com,
       jes@wildopensource.com
Subject: Re: [PATCH] PER_CPU [1/4] - PER_CPU-cpu_tlbstate
Message-Id: <20040708203614.55eba2f5.akpm@osdl.org>
In-Reply-To: <200407090330.i693UPws023956@fire-2.osdl.org>
References: <20040708192127.05c07c65.akpm@osdl.org>
	<200407090330.i693UPws023956@fire-2.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shai Fultheim" <shai@scalex86.org> wrote:
>
> I find out that the following need to be added to PER_CPU-gdt_table, I'll
>  send updated patch once I find why you getting the errors above.

I applied all four patches on top of the current Linus tree, did `make
allmodconfig ; make vmlinux'.  The same occurs with gcc-2.95.3.

Anyway, I dropped everything so please resend all patches once it's sorted.

