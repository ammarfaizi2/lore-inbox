Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUAYU16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUAYU16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:27:58 -0500
Received: from colin2.muc.de ([193.149.48.15]:10251 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265243AbUAYU1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:27:44 -0500
Date: 25 Jan 2004 21:25:57 +0100
Date: Sun, 25 Jan 2004 21:25:57 +0100
From: Andi Kleen <ak@muc.de>
To: John Stoffel <stoffel@lucent.com>
Cc: Andi Kleen <ak@muc.de>, Valdis.Kletnieks@vt.edu,
       Adrian Bunk <bunk@fs.tum.de>, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125202557.GD16962@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de> <20040125174837.GB16962@colin2.muc.de> <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu> <20040125191232.GC16962@colin2.muc.de> <16404.9520.764788.21497@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16404.9520.764788.21497@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 03:21:04PM -0500, John Stoffel wrote:
> 
> Andi> The latest bk tree (post 2.6.2rc1) has a full solution that
> Andi> should cover all architectures.
> 
> Can you post your patch please?  I've been running into this too.  I'm
> compiling 2.6.2-rc1-mm3 right now after having commented out the

It should be in there already. 

> -funit-at-a-time in Makefile.  I'm running gcc 3.3.3 on Debian with
> the stable/unstable/testing branches.  

Did you actually have problems? 

-Andi
