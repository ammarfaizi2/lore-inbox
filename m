Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUFTSdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUFTSdN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 14:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUFTSdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 14:33:12 -0400
Received: from havoc.gtf.org ([216.162.42.101]:54478 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263824AbUFTSdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 14:33:08 -0400
Date: Sun, 20 Jun 2004 14:33:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 455] Mac Sonic Ethernet
Message-ID: <20040620183306.GB26036@havoc.gtf.org>
References: <200406201726.i5KHQIVW001520@anakin.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406201726.i5KHQIVW001520@anakin.of.borg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 07:26:18PM +0200, Geert Uytterhoeven wrote:
> Mac Sonic Ethernet: Kill duplicate `MODULE_LICENSE("GPL");' (already defined in
> included sonic.c) which causes a compile failure
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

ACK
