Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUHRI3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUHRI3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 04:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUHRI3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 04:29:48 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:36812 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S265029AbUHRI3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 04:29:44 -0400
Date: Wed, 18 Aug 2004 10:29:37 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040818082937.GZ29410@pengutronix.de>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-Scan-Signature: c870fec17057476f9780afc870d320a1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 04:05:56AM -0700, Linus Torvalds wrote:
> Well, we've been discussing the 2.6.x.y format for a while, so I see this 
> as an opportunity to actually do it... Will it break automated scripts? 
> Maybe. But on the other hand, we'll never even find out unless we try it 
> some time.

PTXdist(*) works fine with the new scheme, at least as long as the .1
is in EXTRAVERSION and the .1 patch is released as a normal patch on top
of 2.6.8. 

Robert 

(*) http://www.pengutronix.de/software/ptxdist_en.html, used by 
    embedded people to build kernel+userlands 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
