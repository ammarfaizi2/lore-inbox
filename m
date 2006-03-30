Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWC3FMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWC3FMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWC3FMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:12:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751036AbWC3FMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:12:49 -0500
Date: Wed, 29 Mar 2006 21:12:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux@arm.linux.org.uk
Subject: Re: [PATCH 2.6.16-git] defines MMU mode specific syscalls as
 'cond_syscall' and clean-up unneeded macros
Message-Id: <20060329211203.4fffe57b.akpm@osdl.org>
In-Reply-To: <200603301359.08701.hyok.choi@samsung.com>
References: <200603291829.57719.hyok.choi@samsung.com>
	<20060329153251.30826295.akpm@osdl.org>
	<200603301359.08701.hyok.choi@samsung.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hyok S. Choi" <hyok.choi@samsung.com> wrote:
>
> (BTW, I could not guess what part of my previous mail was mangled. I found no 
>  problem when I got the patch from the mailing-list, by gmail?)

It looks like your email client did RFC2464(?) space-stuffing.  Perhaps
your client unstuffs too (if that's possible), in which case you wouldn't
see it.

I don't know, but I'm sure I'm about to find out ;)
