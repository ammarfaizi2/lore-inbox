Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267757AbSLTJZF>; Fri, 20 Dec 2002 04:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbSLTJZF>; Fri, 20 Dec 2002 04:25:05 -0500
Received: from ns.suse.de ([213.95.15.193]:273 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267757AbSLTJZF>;
	Fri, 20 Dec 2002 04:25:05 -0500
Date: Fri, 20 Dec 2002 10:33:07 +0100
From: Dave Jones <davej@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matt Bernstein <matt@theBachChoir.org.uk>, Ed Tomlinson <tomlins@cam.org>,
       Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Message-ID: <20021220103307.A3780@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Matt Bernstein <matt@theBachChoir.org.uk>,
	Ed Tomlinson <tomlins@cam.org>, Paul P Komkoff Jr <i@stingr.net>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.51.0212200127001.877@jester.mews> <Pine.LNX.4.33L2.0212191734240.30841-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0212191734240.30841-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Thu, Dec 19, 2002 at 05:43:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 05:43:14PM -0800, Randy.Dunlap wrote:
 > |
 > | I get a very similar oops, but with amd_k7_agp (2.5.52-mm2). I'm not
 > | bk-savvy as yet, but if pointed at a diff, would be happy to verify it.
 > 
 > 2.5.zz kernel diff snapshots (from bk) are available at
 >   http://www.kernel.org/pub/linux/kernel/v2.5/snapshots/
 > e.g., latest is:
 >   http://www.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.52-bk4.bz2

Latest AGP bits aren't in Linus tree yet. A few more bits to nail
down, and then I'll ask him to pull again.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
