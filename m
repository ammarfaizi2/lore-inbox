Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265325AbUFRQJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUFRQJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFRQIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:08:07 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:7140 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265250AbUFRQHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:07:20 -0400
Date: Fri, 18 Jun 2004 18:06:04 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Matt Mackall <mpm@selenic.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Subject: Re: make checkstack on m68k
Message-ID: <20040618160604.GA29579@wohnheim.fh-wedel.de>
References: <200406161930.VAA16618@pfultra.phil.uni-sb.de> <Pine.LNX.4.58.0406171812440.8197@bonkers.disegno.com.au> <20040617183616.GC29029@wohnheim.fh-wedel.de> <Pine.GSO.4.58.0406172127150.1495@waterleaf.sonytel.be> <20040618121813.GB18258@wohnheim.fh-wedel.de> <Pine.GSO.4.58.0406181537210.11779@waterleaf.sonytel.be> <20040618134313.GG18258@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406190137400.31712@bonkers.disegno.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406190137400.31712@bonkers.disegno.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 June 2004 01:59:27 +1000, Finn Thain wrote:
> 
> Jörn, the best thing about my hack was that it didn't interfere with the
> regexes for the other archs. Andreas better solved that problem by
> providing the result in $1, by using some foreknowlegde of the objdump
> output format.
> 
> I whole-heartedly endorse the signed-off-by-Geert and provided-by-Andreas
> patch on the basis of even less interference with the existing code. i.e.
> 
>     http://lkml.org/lkml/2004/6/18/104

Hmm, convinced.  My perl skills were simply not good enough to see
through all the tricks.  Patch is accepted, I'll integrate and forward
after the weekend.

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
