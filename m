Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267684AbUHKE7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267684AbUHKE7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 00:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267937AbUHKE7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 00:59:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:26846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267684AbUHKE7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 00:59:51 -0400
Date: Tue, 10 Aug 2004 21:59:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Possible dcache BUG
In-Reply-To: <200408110047.32611.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0408102159000.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <200408102342.12792.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
 <200408110047.32611.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I wrote:
> Notably, the output of "/proc/meminfo" and "/proc/slabinfo". "ps
> axm" helps too.

That should be "ps axv" of course. Just shows what a retard I am.

		Linus
