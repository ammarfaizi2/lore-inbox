Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267683AbSLTBga>; Thu, 19 Dec 2002 20:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267684AbSLTBga>; Thu, 19 Dec 2002 20:36:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61875 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267683AbSLTBga>;
	Thu, 19 Dec 2002 20:36:30 -0500
Date: Thu, 19 Dec 2002 17:43:14 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Matt Bernstein <matt@theBachChoir.org.uk>
cc: Ed Tomlinson <tomlins@cam.org>, Paul P Komkoff Jr <i@stingr.net>,
       <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
In-Reply-To: <Pine.LNX.4.51.0212200127001.877@jester.mews>
Message-ID: <Pine.LNX.4.33L2.0212191734240.30841-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2002, Matt Bernstein wrote:

| On Dec 17 Ed Tomlinson wrote:
|
| >Not normally.  If I modprobe via-agp modprobe segfaults (a Rusty's bug),
| >but via_agp and agpgart get loaded (note that - changed to _ when the module
| >is loaded - it has dash in file in the directory).  Doing it this time gets
| >an oops (52bk as of last night):
| [snip]
|
| I get a very similar oops, but with amd_k7_agp (2.5.52-mm2). I'm not
| bk-savvy as yet, but if pointed at a diff, would be happy to verify it.

2.5.zz kernel diff snapshots (from bk) are available at
  http://www.kernel.org/pub/linux/kernel/v2.5/snapshots/
e.g., latest is:
  http://www.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.52-bk4.bz2

-- 
~Randy

