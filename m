Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262443AbSI3R1q>; Mon, 30 Sep 2002 13:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSI3R1q>; Mon, 30 Sep 2002 13:27:46 -0400
Received: from air-2.osdl.org ([65.172.181.6]:46600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262443AbSI3R1p>;
	Mon, 30 Sep 2002 13:27:45 -0400
Date: Mon, 30 Sep 2002 10:32:48 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic/exception dump support in 2.5?
In-Reply-To: <200209300816.20040.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.33L2.0209301032140.4649-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Marc-Christian Petersen wrote:

| Hi Randy,
|
| > | On Sun, 2002-09-29 at 21:42, Shawn Starr wrote:
| > | >
| > | > It would really be nice if I could capture kernel exceptions/and oopsies
| > | > on a file, or over a network connection. Redirecting console=lp0 to
| > | > printer doesnt really let me paste dumps to LKML =)
| > | >
| > | > Any solutions? Will we have a way to properly dump kernel failures
| > | > (exceptions/oopies) somewhere?
| > |
| > | The netdump patch can do this, including the actual kernel image
| > | -
|
| > Is this something different from netconsole?
| > Where can I find netdump?
| netdump == netconsole.
|
| Find it here: http://people.redhat.com/mingo/netconsole-patches/
|
| Another work done by Ingo =) ... Works great, is a part of WOLK too.

Yes, I know about netconsole; just confused by the netdump name.

Thanks.
-- 
~Randy

