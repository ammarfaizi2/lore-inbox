Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVAKBD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVAKBD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVAKA6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:58:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:400 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262613AbVAKAtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:49:11 -0500
Date: Mon, 10 Jan 2005 16:49:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V4 [1/4]: Arch specific page zeroing during page fault
Message-ID: <20050110164909.K2357@build.pdx.osdl.net>
References: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain> <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org> <Pine.LNX.4.58.0501101552100.25654@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501101553140.25654@schroedinger.engr.sgi.com> <20050110164157.R469@build.pdx.osdl.net> <Pine.LNX.4.58.0501101645250.25962@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0501101645250.25962@schroedinger.engr.sgi.com>; from clameter@sgi.com on Mon, Jan 10, 2005 at 04:46:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Lameter (clameter@sgi.com) wrote:
> Use bk13 as I indicated.

Ah, so you did, thanks ;-)
-chris
--
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
