Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWISM2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWISM2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 08:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWISM2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 08:28:12 -0400
Received: from khc.piap.pl ([195.187.100.11]:38547 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030212AbWISM2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 08:28:11 -0400
To: sergio@sergiomb.no-ip.org
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au, billm@suburbia.net
Subject: Re: Math-emu kills the kernel on Athlon64 X2
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	<1158623391.13821.4.camel@localhost.portugal>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 19 Sep 2006 14:28:08 +0200
In-Reply-To: <1158623391.13821.4.camel@localhost.portugal> (Sergio Monteiro Basto's message of "Tue, 19 Sep 2006 00:49:51 +0100")
Message-ID: <m3fyeof3c7.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> writes:
> I think, math emulation is for 486 and older. 486 DX2 was the first one
> who have math co processor, on earlier processor it should be disable .

Actually, 486 DX had built-in FPU as well. It was missing from 486SX
(486SX + optional 487 FPU = 486DX).

For 386(DX|SX) there were 387(DX|SX) (386SX used 16-bit bus).

Many 32-bit motherboards had a socket for Weitek (3167 for 386DX or 4167
for 486). I think I remember a board with 386DX and 287 socket as well.

486DX2 meant the external clock was half the internal.
-- 
Krzysztof Halasa
