Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUFGIAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUFGIAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 04:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUFGIAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 04:00:31 -0400
Received: from mail-08.iinet.net.au ([203.59.3.40]:56987 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262106AbUFGIAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 04:00:30 -0400
Subject: Re: building MINIX on LINUX using gcc
From: James Buchanan <buchanan@iinet.net.au>
To: ckkashyap@spymac.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040607061407.37FF54C0BE@spy10.spymac.net>
References: <20040607061407.37FF54C0BE@spy10.spymac.net>
Content-Type: text/plain
Message-Id: <1086595241.2226.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 18:00:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I would like to build the MINIX kerenel on a LINUX machine using gcc + nasm!
> 
> Is there MINIX source that is buildable on LINUX platform available?

comp.os.minix is the place to be!

See you there.

James

PS.  Get the official MINIX sources, and use a XX-to-YY translator or
write your own that converts the assembler sources to NASM.  It
shouldn't be that difficult., or do it by hand, since there's not much
of it.  The C code is ANSI and GCC should handle it.  Then you can
rewrite the Makefiles and possibly add linker scripts for LD, and you'll
have MINIX built on Linux in no time.


