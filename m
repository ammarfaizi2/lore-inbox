Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbUB2VDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbUB2VDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:03:30 -0500
Received: from hera.kernel.org ([63.209.29.2]:56738 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262137AbUB2VD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:03:29 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
Date: Sun, 29 Feb 2004 21:03:02 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1tk26$c1o$1@terminus.zytor.com>
References: <200402291942.45392.mmazur@kernel.pl> <c1thfk$bjm$1@terminus.zytor.com> <200402292130.55743.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078088582 12345 63.209.29.3 (29 Feb 2004 21:03:02 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 29 Feb 2004 21:03:02 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200402292130.55743.mmazur@kernel.pl>
By author:    Mariusz Mazur <mmazur@kernel.pl>
In newsgroup: linux.dev.kernel
>
> On Sunday 29 of February 2004 21:19, H. Peter Anvin wrote:
> > Dumb but important question: what is the copyright on these headers?
> 
> They are based on original linux headers, so gpl of course.
> 

If so, we actually have a bit of an issue w.r.t. the potential
legality of these headers.  Technically they're incompatible with LGPL
and BSD-licensed libraries; I think we need some kind of official
declaration that compiling against them is permitted.

	-hpa
