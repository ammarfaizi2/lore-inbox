Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263972AbTCUUK0>; Fri, 21 Mar 2003 15:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263850AbTCUUJR>; Fri, 21 Mar 2003 15:09:17 -0500
Received: from havoc.daloft.com ([64.213.145.173]:48108 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S263846AbTCUTbE>;
	Fri, 21 Mar 2003 14:31:04 -0500
Date: Fri, 21 Mar 2003 14:42:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: document useraccess lib functions too
Message-ID: <20030321194201.GF10905@gtf.org>
References: <200303212028.h2LKS9lk026347@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303212028.h2LKS9lk026347@hraefn.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 08:28:09PM +0000, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/lib/usercopy.c linux-2.5.65-ac2/arch/i386/lib/usercopy.c
> --- linux-2.5.65/arch/i386/lib/usercopy.c	2003-02-10 18:37:55.000000000 +0000
> +++ linux-2.5.65-ac2/arch/i386/lib/usercopy.c	2003-03-06 23:12:31.000000000 +0000


akpm pushed this one...
