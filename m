Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbTAaIb7>; Fri, 31 Jan 2003 03:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbTAaIb7>; Fri, 31 Jan 2003 03:31:59 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:16358 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id <S267732AbTAaIb6>;
	Fri, 31 Jan 2003 03:31:58 -0500
Date: Fri, 31 Jan 2003 10:41:17 +0200 (EET)
From: Catalin BOIE <util@ns2.deuroconsult.ro>
X-X-Sender: <util@hosting.rdsbv.ro>
To: Eng Se-Hsieng <g0202512@nus.edu.sg>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Unexpected EOF when unzipping kernel source 2.4.18
In-Reply-To: <720FB032F37C0D45A11085D881B033684CBC40@MBXSRV24.stu.nus.edu.sg>
Message-ID: <Pine.LNX.4.33.0301311040340.16563-100000@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2003, Eng Se-Hsieng wrote:

> [1.] One line summary of the problem: Unexpected EOF in archive of linux
> kernel 2.4.18
> [2.] Full description of the problem/report:
>
> linux/arch/sh/mm/cache-sh4.c
> gzip: stdin: unexpected end of file
> linux/arch/sh/mm/clear_page.S
> linux/arch/sh/mm/copy_page.S
> tar: Unexpected EOF in archive
> tar: Unexpected EOF in archive
> tar: Error is not recoverable: exiting now.

The archive is very probably partialy downloaded.
Check sizes and then the md5.

---
Catalin(ux) BOIE
catab@deuroconsult.ro

