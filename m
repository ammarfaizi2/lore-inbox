Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVBKSKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVBKSKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVBKSKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:10:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:42466 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262076AbVBKSKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:10:18 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc64: Implement a vDSO and use it for signal trampoline #3
Date: Fri, 11 Feb 2005 19:10:00 +0100
User-Agent: KMail/1.5.4
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1108002773.7733.196.camel@gaston>
In-Reply-To: <1108002773.7733.196.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502111910.00725.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

are you copyrighting under a new pseudonym? E.g.:

On Thursday 10 February 2005 03:32, Benjamin Herrenschmidt wrote:
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/ppc64/kernel/vdso32/sigtramp.S	2005-02-02
> 13:28:01.000000000 +1100 @@ -0,0 +1,300 @@
> +/*
> + * Signal trampolines for 32 bits processes in a ppc64 kernel for
> + * use in the vDSO
> + *
> + * Copyright (C) 2004 Benjamin Herrenschmuidt
                                            ^
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/ppc64/kernel/vdso32/datapage.S	2005-02-02
> 13:28:01.000000000 +1100 @@ -0,0 +1,68 @@
> +/*
> + * Access to the shared data page by the vDSO & syscall map
> + *
> + * Copyright (C) 2004 Benjamin Herrenschmuidt

Who's that guy?

Pete

