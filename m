Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbRL1Q5S>; Fri, 28 Dec 2001 11:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRL1Q5I>; Fri, 28 Dec 2001 11:57:08 -0500
Received: from ns.suse.de ([213.95.15.193]:16400 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282511AbRL1Q4y>;
	Fri, 28 Dec 2001 11:56:54 -0500
Date: Fri, 28 Dec 2001 17:56:53 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-hams@vger.kernel.org>
Subject: Re: link error in SCC driver
In-Reply-To: <20011228164111.GK7481@wiggy.net>
Message-ID: <Pine.LNX.4.33.0112281756140.22038-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Wichert Akkerman wrote:

> If I compile a kernel with a recent binutils and the scc driver
> I get the now famous linking error:
>
> net/network.o(.text.lock+0x2b38): undefined reference to `local symbols
> in discarded section .text.exit'

output of Keiths reference_discarded.pl would be useful.
http://kernelnewbies.org/scripts/reference_discarded.pl

Dave.
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

