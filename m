Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267020AbSK2Lgf>; Fri, 29 Nov 2002 06:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbSK2Lgf>; Fri, 29 Nov 2002 06:36:35 -0500
Received: from cibs9.sns.it ([192.167.206.29]:55569 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S267020AbSK2Lge>;
	Fri, 29 Nov 2002 06:36:34 -0500
Date: Fri, 29 Nov 2002 12:43:55 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: Re: linux/security.h missing in fs/hugetlbfs/inode.c
In-Reply-To: <Pine.LNX.4.43.0211291238360.986-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.4.43.0211291243200.1202-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I was forgetting,

this is about kernel 2.5.50

bests
Luigi

On Fri, 29 Nov 2002 venom@sns.it wrote:

> Date: Fri, 29 Nov 2002 12:40:17 +0100 (CET)
> From: venom@sns.it
> To: linux-kernel@vger.kernel.org
> Subject: linux/security.h missing in fs/hugetlbfs/inode.c
>
>
> #include <linux/security.h>
>
> is missing in file fs/hugetlbfs/inode.c,
> so security_ops is undeclared during compilation.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

