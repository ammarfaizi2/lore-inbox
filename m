Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284542AbRL2BHH>; Fri, 28 Dec 2001 20:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287038AbRL2BG5>; Fri, 28 Dec 2001 20:06:57 -0500
Received: from ns.suse.de ([213.95.15.193]:25357 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287037AbRL2BGl>;
	Fri, 28 Dec 2001 20:06:41 -0500
Date: Sat, 29 Dec 2001 02:06:41 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj7 -- fdomain.c: In function `do_fdomain_16x0_intr':
 `io_request_lock' undeclared
In-Reply-To: <1009584742.22848.2.camel@stomata.megapathdsl.net>
Message-ID: <Pine.LNX.4.33.0112290206210.27193-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Dec 2001, Miles Lane wrote:

> ../fdomain.c: In function `do_fdomain_16x0_intr':
> ../fdomain.c:1268: `io_request_lock' undeclared (first use in this

Also present in Linus' tree. Another victim in need of bio work.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

