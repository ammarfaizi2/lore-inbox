Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUFGIgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUFGIgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 04:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUFGIgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 04:36:50 -0400
Received: from spy10.spymac.net ([213.218.8.210]:24285 "EHLO spy10.spymac.net")
	by vger.kernel.org with ESMTP id S262138AbUFGIgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 04:36:49 -0400
Content-Disposition: inline
Content-Transfer-Encoding: binary
Mime-Version: 1.0
From: <ckkashyap@spymac.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: building MINIX on LINUX using gcc
Reply-To: ckkashyap@spymac.com
Content-Type: text/plain
X-Mailer: AtMail Corp 3.64 - http://webbasedemail.com/
X-Origin: 203.145.179.173
Message-Id: <20040607083648.489254C050@spy10.spymac.net>
Date: Mon,  7 Jun 2004 02:36:48 -0600 (MDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>comp.os.minix is the place to be!
Thanks...I just signed up!

>PS. Get the official MINIX sources, and use a XX-to-YY translator or
Where do I get the official sources from?

>write your own that converts the assembler sources to NASM. It
>shouldn't be that difficult., or do it by hand, since there's not much
>of it. The C code is ANSI and GCC should handle it. Then you can
>rewrite the Makefiles and possibly add linker scripts for LD, and you'll
>have MINIX built on Linux in no time.

What can I do to make it loadable by GRUB or so. I understand that /minix is a concatination of the various a.outs. Can I write a tiny executable 
that will get loaded by GRUB that loaded /minix beyond 1M. Are there many initializations that need to be done before this?

regards,
Kashyap



---- Msg sent via Spymac Mail - http://www.spymac.com
