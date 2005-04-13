Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVDMUEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVDMUEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 16:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVDMUEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 16:04:32 -0400
Received: from hera.kernel.org ([209.128.68.125]:6573 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261155AbVDMUEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 16:04:22 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: New SCM and commit list
Date: Wed, 13 Apr 2005 20:04:06 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d3jtvm$l9f$1@terminus.zytor.com>
References: <1113174621.9517.509.camel@gaston> <1113189922.9899.6.camel@mulgrave> <20050411205317.GA26246@kroah.com> <Pine.LNX.4.58.0504111424270.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1113422647 21808 127.0.0.1 (13 Apr 2005 20:04:07 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 13 Apr 2005 20:04:07 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0504111424270.1267@ppc970.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
> 
> On Mon, 11 Apr 2005, Greg KH wrote:
> > 
> > I have a feeling that the kernel.org mirror system is just going to
> > _love_ us using it to store temporary git trees :)
> 
> I don't think kernel.org mirrors the private home directories, so it you
> do _temporary_ trees, just make them readable in your private home
> directory rather than in /pub/linux/kernel/people. For people with 
> kernel.org accounts, we can use that as the "bkbits.net" thing.
> 
> For really public hosting, we need to find some other approach. 
> 

It's also pretty trivial to set up an additional /pub hierarchy, like
the current /pub/scm, which is up to individual mirrors to pick up or
not to pick up.  We only require /pub/linux and /pub/software to be
mirrored.

	-hpa
