Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbULMM3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbULMM3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbULMM3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:29:31 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:57017 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262241AbULMM33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:29:29 -0500
Date: Mon, 13 Dec 2004 13:29:25 +0100
From: David Weinehall <tao@debian.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3 vs clock
Message-ID: <20041213122925.GT27718@khan.acc.umu.se>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200412041111.16055.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412041111.16055.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 11:11:16AM -0500, Gene Heskett wrote:
> At -rc2 my clock kept fairly decent time, but -rc3 is running fast, 
> about 30 seconds an hour fast.

Lucky you. Each time I suspend my laptop the clock speeds up
approximately x2...  Usually, the time it takes me to get from home to
work means that the computer tells me I arrived half an hour late...

> I've been using ntpdate, is that now officially deprecated?

I kind of doubt that...


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
