Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSI3GLL>; Mon, 30 Sep 2002 02:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbSI3GLL>; Mon, 30 Sep 2002 02:11:11 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:37351 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261934AbSI3GLK> convert rfc822-to-8bit; Mon, 30 Sep 2002 02:11:10 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic/exception dump support in 2.5?
Date: Mon, 30 Sep 2002 08:16:20 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209300816.20040.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> | On Sun, 2002-09-29 at 21:42, Shawn Starr wrote:
> | >
> | > It would really be nice if I could capture kernel exceptions/and oopsies
> | > on a file, or over a network connection. Redirecting console=lp0 to
> | > printer doesnt really let me paste dumps to LKML =)
> | >
> | > Any solutions? Will we have a way to properly dump kernel failures
> | > (exceptions/oopies) somewhere?
> |
> | The netdump patch can do this, including the actual kernel image
> | -

> Is this something different from netconsole?
> Where can I find netdump?
netdump == netconsole.

Find it here: http://people.redhat.com/mingo/netconsole-patches/

Another work done by Ingo =) ... Works great, is a part of WOLK too.

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
