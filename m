Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSKVBjT>; Thu, 21 Nov 2002 20:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSKVBjT>; Thu, 21 Nov 2002 20:39:19 -0500
Received: from holomorphy.com ([66.224.33.161]:60547 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263760AbSKVBjT>;
	Thu, 21 Nov 2002 20:39:19 -0500
Date: Thu, 21 Nov 2002 17:43:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] Latest -rmap15 stuff against 2.4.20-rc2-ac2
Message-ID: <20021122014333.GT23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021121225507.GH20701@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121225507.GH20701@stingr.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 01:55:07AM +0300, Paul P Komkoff Jr wrote:
> diff -Nru a/include/linux/mm.h b/include/linux/mm.h
> --- a/include/linux/mm.h	Fri Nov 22 00:36:57 2002
> +++ b/include/linux/mm.h	Fri Nov 22 00:36:57 2002
> @@ -1,5 +1,23 @@
>  #ifndef _LINUX_MM_H
>  #define _LINUX_MM_H
> +/*
> + * Copyright (c) 2002. All rights reserved.
> + *
> + * This software may be freely redistributed under the terms of the
> + * GNU General Public License.
[...]

Shouldn't this be part of a separate attribution update?
(also, it'd be better to just remove the buffer cache)


Bill
