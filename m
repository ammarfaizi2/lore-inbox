Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUHKIGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUHKIGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 04:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267989AbUHKIGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 04:06:13 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:29424 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S267967AbUHKIFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 04:05:51 -0400
Date: Wed, 11 Aug 2004 10:05:22 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Possible dcache BUG
Message-ID: <20040811080522.GB11214@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Gene Heskett <gene.heskett@verizon.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408102342.12792.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org> <200408110047.32611.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102159000.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408102159000.1839@ppc970.osdl.org>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 21:59:48 -0700, Linus Torvalds wrote:
> That should be "ps axv" of course. Just shows what a retard I am.

Note that some of those columns won't work as advertised. I'd be
particularly suspicious about DRS and TRS.

Roger
