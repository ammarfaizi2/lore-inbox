Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbUBVUJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUBVUJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:09:27 -0500
Received: from hera.kernel.org ([63.209.29.2]:46754 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261739AbUBVUJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:09:26 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Date: Sun, 22 Feb 2004 20:09:21 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1b29h$sck$1@terminus.zytor.com>
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040221135439.GA310@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077480561 29077 63.209.29.3 (22 Feb 2004 20:09:21 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 22 Feb 2004 20:09:21 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040221135439.GA310@elf.ucw.cz>
By author:    Pavel Machek <pavel@ucw.cz>
In newsgroup: linux.dev.kernel
>
> Hi!
> 
> 
> > Which flies in the face of "Be strict in what you generate, be liberal in 
> > what you accept". A lot of the functions are _not_ willing to be liberal 
> > in what they accept. Which sometimes just makes the problem worse, for no 
> > good reason.
> 
> Be liberal in what you accept used to be good rule... until security
> became important. While it is still nice from ease-of-use viewpoint,
> its bad when you want it secure.
> 								Pavel

"Be liberal, but cautious, in what you accept" is pretty much the new
rule.

	-hpa
