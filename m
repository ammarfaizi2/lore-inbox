Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUA0KTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 05:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUA0KTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 05:19:55 -0500
Received: from [212.220.30.16] ([212.220.30.16]:11496 "EHLO spot.plotinka.ru")
	by vger.kernel.org with ESMTP id S263166AbUA0KTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 05:19:54 -0500
Date: Tue, 27 Jan 2004 15:19:42 +0500
From: m0sia <m0sia@plotinka.ru>
To: John Heil <kerndev@sc-software.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is gcc 3.2.2 suitable for kernel builds?
Message-Id: <20040127151942.39ee0bba.m0sia@plotinka.ru>
In-Reply-To: <Pine.LNX.4.58.0401262211480.7728@scsoftware.sc-software.com>
References: <Pine.LNX.4.58.0401262211480.7728@scsoftware.sc-software.com>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004 22:15:29 -0800 (PST)
John Heil <kerndev@sc-software.com> wrote:

> 
> It seems that some gcc 3.2.2 optimizations are generating
> bogus code sequences.
> 
> Has anyone else had compiler issues w gcc 3.2.2?
> 
> Thanks much,
> 
> johnh
> 
> -
> -----------------------------------------------------------------
> John Heil
> South Coast Software
> Custom systems software for UNIX and IBM MVS mainframes
> 1-714-774-6952
> johnhscs@sc-software.com
> http://www.sc-software.com
> -----------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I'm using gcc 3.2.2 and everything is "ok". What optimization are you
using? Maybe you will upgrade to 3.2.3?
