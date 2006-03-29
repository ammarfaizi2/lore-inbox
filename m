Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWC2XbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWC2XbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWC2XbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:31:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751271AbWC2XbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:31:00 -0500
Date: Wed, 29 Mar 2006 15:32:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux@arm.linux.org.uk
Subject: Re: [PATCH 2.6.16-git] defines MMU mode specific syscalls as
 'cond_syscall' and clean-up unneeded macros
Message-Id: <20060329153251.30826295.akpm@osdl.org>
In-Reply-To: <200603291829.57719.hyok.choi@samsung.com>
References: <200603291829.57719.hyok.choi@samsung.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hyok S. Choi" <hyok.choi@samsung.com> wrote:
>
> diff --git a/arch/frv/kernel/entry.S b/arch/frv/kernel/entry.S
> index 1d21c8d..a9b5952 100644
> --- a/arch/frv/kernel/entry.S
> +++ b/arch/frv/kernel/entry.S

Your email client mangled this patch more than I am prepared to unmangle
it.  Probably you need to use a text/plain attachment when resending,
please.
