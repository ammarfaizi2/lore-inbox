Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261909AbSI3EAE>; Mon, 30 Sep 2002 00:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbSI3EAE>; Mon, 30 Sep 2002 00:00:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23312 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261909AbSI3EAD>;
	Mon, 30 Sep 2002 00:00:03 -0400
Date: Sun, 29 Sep 2002 21:00:05 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic/exception dump support in 2.5?
In-Reply-To: <1033334307.13795.11.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0209292059240.2691-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Sep 2002, Alan Cox wrote:

| On Sun, 2002-09-29 at 21:42, Shawn Starr wrote:
| >
| > It would really be nice if I could capture kernel exceptions/and oopsies
| > on a file, or over a network connection. Redirecting console=lp0 to
| > printer doesnt really let me paste dumps to LKML =)
| >
| > Any solutions? Will we have a way to properly dump kernel failures
| > (exceptions/oopies) somewhere?
|
| The netdump patch can do this, including the actual kernel image
| -

Is this something different from netconsole?
Where can I find netdump?

Thanks,
-- 
~Randy

