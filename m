Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbUBYByO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbUBYByL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:54:11 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:59010 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S262581AbUBYBwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:52:53 -0500
Date: Tue, 24 Feb 2004 17:52:51 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       Adrian Bunk <bunk@fs.tum.de>, Herbert Poetzl <herbert@13thfloor.at>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
Message-ID: <20040225015251.GA5654@dingdong.cryptoapps.com>
References: <7F740D512C7C1046AB53446D37200173EA2684@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D37200173EA2684@scsmsx402.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 03:15:18PM -0800, Nakajima, Jun wrote:

> Near branch with 66H prefix:
>   As documented in PRM the behavior is implementation specific and
>   should avoid using 66H prefix on near branches.

Presumably this isn't a problem with current gcc's right?


