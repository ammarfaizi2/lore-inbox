Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269265AbUIBXMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269265AbUIBXMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUIBXIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:08:16 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:59888 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269189AbUIBXF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:05:26 -0400
Date: Thu, 2 Sep 2004 19:05:26 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902230526.GB15505@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <412D9FFA.6030307@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412D9FFA.6030307@hist.no>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's wrong with ~/.thumbcache or a daemon that manages system wide cache?

I have no problem if a plugin wants to parse a file and split it inside the
file-as-dir. However, multiple file streams are a cross-platform nighmare.
Anyone who's used mac os knows this.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
