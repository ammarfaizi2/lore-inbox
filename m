Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUFKEKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUFKEKU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 00:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUFKEKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 00:10:20 -0400
Received: from smtp.enter.net ([216.193.128.24]:15110 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S263745AbUFKEKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 00:10:15 -0400
From: Andrew Rodland <arodland@entermail.net>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] -ar patchset
Date: Fri, 11 Jun 2004 00:10:19 -0400
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406110010.19781.arodland@entermail.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does the world need yet another kernel patchset? There are a couple of 
reasons, basically. The first is that I have a bunch of free time coming up, 
and I want to get back in sync with the kernel hacking process. The other is 
that I want to strike a balance: a little more experimental than -ck, but 
with less heavy updating and (I hope) potential instability than -mm.

I intend to release mostly for release kernels only; this one is for 2.6.7-rc3 
because I'm impatient and because that is what Con is currently syncing up 
with.

All that being said, at http://hobbs.dynup.net/patches/2.6.7-rc3-ar1/ you can 
find the initial version of the patch, with staircase, 
autoregulate-swappiness, supermount-ng, ext3 and reiser improvements, and a 
free toy in every box. Passes the boot test on i386; if it breaks anywhere 
that rc3 doesn't, I'd love to hear about it. If it makes your machine twice 
as fast, I'd love to hear about that too.

Andrew Rodland < arodland@entermail.net >

P.S. I read via GMANE, so Cc:ing me if you want my attention couldn't hurt.
