Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTLCIZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 03:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTLCIZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 03:25:51 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:15049 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264510AbTLCIZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 03:25:50 -0500
Subject: Re: 2.6 for ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3FCCF6B2.2000709@tait.co.nz>
References: <3FCCF6B2.2000709@tait.co.nz>
Content-Type: text/plain
Message-Id: <1070439896.4303.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 19:24:57 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-03 at 07:31, Dmytro Bablinyuk wrote:
> Could anybody please tell me at what stage the 2.6(-test11) kernel 
> regarding ppc arch.
> Right now if I am trying to compile it fails in several places in 
> arch/ppc folder with obvious errors (for: 8xx cpu, FADS platform  used 
> uclibc).

I'm not sure what is the exact state of the 8xx support in the main
tree, but for embedded ppc related question, you should ask on the
linuxppc-embedded list (lists.linuxppc.org). You may also have more
luck using the "linuxppc-2.5" tree on source.mvista.com for such
things (or my linuxppc-2.5-benh for powermac related stuffs).

Ben.


