Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWF1Utm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWF1Utm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWF1Utm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:49:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23775 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751519AbWF1Utl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:49:41 -0400
Date: Wed, 28 Jun 2006 22:48:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 3/4] [Suspend2] Correct kernel/power/smp.c credit.
Message-ID: <20060628204847.GA13397@elf.ucw.cz>
References: <20060626164637.10641.63979.stgit@nigel.suspend2.net> <20060626164647.10641.37727.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626164647.10641.37727.stgit@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-06-27 02:46:48, Nigel Cunningham wrote:
> Modify kernel/power/smp.c credit to my current address.

> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

ACK on this one... if you have similar easy stuff, please retransmit
just that.
							Pavel

> diff --git a/kernel/power/smp.c b/kernel/power/smp.c
> index 5957312..c102e7c 100644
> --- a/kernel/power/smp.c
> +++ b/kernel/power/smp.c
> @@ -2,7 +2,7 @@
>   * drivers/power/smp.c - Functions for stopping other CPUs.
>   *
>   * Copyright 2004 Pavel Machek <pavel@suse.cz>
> - * Copyright (C) 2002-2003 Nigel Cunningham <ncunningham@clear.net.nz>
> + * Copyright (C) 2002-2003 Nigel Cunningham <nigel@suspend2.net>
>   *
>   * This file is released under the GPLv2.
>   */
> 
> --
> Nigel Cunningham		nigel at suspend2 dot net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
