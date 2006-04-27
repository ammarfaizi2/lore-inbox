Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWD0IAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWD0IAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWD0IAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:00:49 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:21720 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964869AbWD0IAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:00:49 -0400
Date: Thu, 27 Apr 2006 10:00:39 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nguyen Anh Quynh <aquynh@gmail.com>
Subject: Re: [PATCH 02/02] Process Events - License Change
Message-ID: <20060427100039.4e8cfa3e@localhost.localdomain>
In-Reply-To: <1145956350.28976.141.camel@stark>
References: <1145956109.28976.133.camel@stark>
	<1145956350.28976.141.camel@stark>
Organization: Bull S.A.
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/04/2006 10:03:28,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/04/2006 10:03:28,
	Serialize complete at 27/04/2006 10:03:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Changing the license is okay for me,

Cheers,

Acked-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

On Tue, 25 Apr 2006 02:12:30 -0700
Matt Helsley <matthltc@us.ibm.com> wrote:

> Change the license on the process event structure passed between kernel and
> userspace.
> 
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> 
> --
> 
> Index: linux-2.6.17-rc2/include/linux/cn_proc.h
> ===================================================================
> --- linux-2.6.17-rc2.orig/include/linux/cn_proc.h
> +++ linux-2.6.17-rc2/include/linux/cn_proc.h
> @@ -1,27 +1,20 @@
>  /*
>   * cn_proc.h - process events connector
>   *
>   * Copyright (C) Matt Helsley, IBM Corp. 2005
>   * Based on cn_fork.h by Nguyen Anh Quynh and Guillaume Thouvenin
> - * Original copyright notice follows:
>   * Copyright (C) 2005 Nguyen Anh Quynh <aquynh@gmail.com>
>   * Copyright (C) 2005 Guillaume Thouvenin <guillaume.thouvenin@bull.net>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2.1 of the GNU Lesser General Public License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>   */
>  
>  #ifndef CN_PROC_H
>  #define CN_PROC_H
>  
> 
> 
