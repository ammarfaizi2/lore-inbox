Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268128AbUHKRlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268128AbUHKRlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbUHKRlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:41:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:2539 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268128AbUHKRlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:41:44 -0400
Date: Wed, 11 Aug 2004 10:19:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: phillip@lougher.demon.co.uk, leiyang@nec-labs.com,
       linux-kernel@vger.kernel.org
Subject: Re: Compression algorithm in cloop
Message-Id: <20040811101923.6a95215e.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0408111918120.23115@alpha.polcom.net>
References: <411A4D34.6000104@lougher.demon.co.uk>
	<Pine.LNX.4.60.0408111918120.23115@alpha.polcom.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 19:21:50 +0200 (CEST) Grzegorz Kulewski wrote:

| On Wed, 11 Aug 2004, Phillip Lougher wrote:
| 
| >> Where should I start from? Really a newbie to this,
| >> appreciate any comments and suggestions!!
| >
| > There has been discussion on this list before about adding
| > bzip2 support to the kernel.  Do a search on the list for this.
| 
| Long, long ago there was something called e2compr. They had bzip2 in the 
| kernel. I remember 40 seconds mc start time on disk compressed with bzip2 
| on i486-DX 40 MHz... :-)

still at
  http://e2compr.sourceforge.net/

--
~Randy
