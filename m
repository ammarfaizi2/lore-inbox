Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUJDLvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUJDLvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 07:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUJDLvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 07:51:23 -0400
Received: from mato.luukku.com ([193.209.83.251]:21484 "EHLO mato.luukku.com")
	by vger.kernel.org with ESMTP id S268033AbUJDLvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 07:51:15 -0400
Message-ID: <41613937.8BF0FE0D@users.sourceforge.net>
Date: Mon, 04 Oct 2004 14:51:19 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>
Cc: Florian Bohrer <Florian.Bohrer@t-online.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH] AES x86-64-asm impl.
References: <2KWl4-wq-25@gated-at.bofh.it> <m3acv4zz5f.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Florian.Bohrer@t-online.de (Florian Bohrer) writes:
> > the asm-code is from Jari Ruusu (loop-aes).
> > the org. glue-code is from Fruhwirth Clemens.
> 
> Thanks. I will add it to the x86-64 patchkit.

Here we go again...

Linus promised that he will not merge my code, and I am quite happy with my
code not being anywhere near mainline linux cryptoapi.

Linus, please consider dropping this.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
