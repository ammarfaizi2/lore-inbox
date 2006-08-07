Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWHGQD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWHGQD2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWHGQD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:03:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:37351 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWHGQD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:03:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EGQVF1W9roSeJvkSs96OQBCTM3Zt3VuuKMBwBqRlWGp7fNtWEK1us+8V+WpBjc+dEAYy6FgYKL0F72YzRLCtYg8ztcX4Oj2Clc6b7pMmykz5+EyLwwj/B1E1fCVYxFU/uo2x/YXDfa9gbGMUIsp0s8eCe6CJjZ1Pc4PHfQGp6A8=
Date: Mon, 7 Aug 2006 20:03:27 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: Re: [patch] s390: hypfs comment cleanup.
Message-ID: <20060807160327.GA6835@martell.zuzino.mipt.ru>
References: <20060807150807.GG10416@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807150807.GG10416@skybase>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 05:08:07PM +0200, Martin Schwidefsky wrote:
> [S390] hypfs comment cleanup.

Please, just delete file lines as they carry no additional info.

> --- linux-2.6/arch/s390/hypfs/hypfs_diag.c
> +++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c
> @@ -1,5 +1,5 @@
>  /*
> - *  fs/hypfs/hypfs_diag.c
> + *  arch/s390/hypfs/hypfs_diag.c
>   *    Hypervisor filesystem for Linux on s390. Diag 204 and 224
>   *    implementation.
>   *

> --- linux-2.6/arch/s390/hypfs/hypfs_diag.h
> +++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.h
> @@ -1,5 +1,5 @@
>  /*
> - *  fs/hypfs/hypfs_diag.h
> + *  arch/s390/hypfs_diag.h
>   *    Hypervisor filesystem for Linux on s390.
>   *
>   *    Copyright (C) IBM Corp. 2006

> --- linux-2.6/arch/s390/hypfs/hypfs.h
> +++ linux-2.6-patched/arch/s390/hypfs/hypfs.h
> @@ -1,5 +1,5 @@
>  /*
> - *  fs/hypfs/hypfs.h
> + *  arch/s390/hypfs/hypfs.h
>   *    Hypervisor filesystem for Linux on s390.
>   *
>   *    Copyright (C) IBM Corp. 2006

> --- linux-2.6/arch/s390/hypfs/inode.c
> +++ linux-2.6-patched/arch/s390/hypfs/inode.c
> @@ -1,5 +1,5 @@
>  /*
> - *  fs/hypfs/inode.c
> + *  arch/s390/hypfs/inode.c

