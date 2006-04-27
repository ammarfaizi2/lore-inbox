Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWD0Ghr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWD0Ghr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWD0Ghr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:37:47 -0400
Received: from wproxy.gmail.com ([64.233.184.227]:14751 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964965AbWD0Ghq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:37:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QPyTtxyaxAu/fYfYeh1GnQ6mShApt4RmVXN+Sg+Bks25s5ql62Rw5eC12T9ON8G/XRri0mRR8Eg4MNJ23vqKJYi378+J6oZFhUgMMONXmA34XfLTPrc/IuoWXIb+aQcPC39hh/S3IwBI0hkiU/rLyBYG2TmKVu+TGf+jl5E5xZI=
Message-ID: <9cde8bff0604262337t3031928chcb96ba893a94e777@mail.gmail.com>
Date: Thu, 27 Apr 2006 15:37:43 +0900
From: "Nguyen Anh Quynh" <aquynh@gmail.com>
To: "Matt Helsley" <matthltc@us.ibm.com>
Subject: Re: [PATCH 02/02] Process Events - License Change
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Guillaume Thouvenin" <guillaume.thouvenin@bull.net>
In-Reply-To: <1145956350.28976.141.camel@stark>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145956109.28976.133.camel@stark>
	 <1145956350.28976.141.camel@stark>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I agree with the license change proposed by Matt Helsley.

Acked-by: Nguyen Anh Quynh <aquynh@gmail.com>

On 4/25/06, Matt Helsley <matthltc@us.ibm.com> wrote:
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
>


--
Regards,
Quynh
