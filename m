Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUBVD3P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUBVD3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:29:15 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:53376 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261659AbUBVD3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:29:14 -0500
Date: Sat, 21 Feb 2004 19:29:13 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222032913.GA14149@dingdong.cryptoapps.com>
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 07:28:24PM -0800, Linus Torvalds wrote:

> What happened to the experiment of having slab pages on the
> (in)active lists and letting them be free'd that way? Didn't
> somebody already do that? Ed Tomlinson and Craig Kulesa?

Stupid question perhaps?  But how would I implement this to test it
out. It doesn't seem entirely trivial but I'm largely ignorant in
these parts of the kernel.


