Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVDHRT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVDHRT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVDHRTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:19:21 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:36566 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262880AbVDHRPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:15:33 -0400
X-ORBL: [68.120.153.162]
Date: Fri, 8 Apr 2005 10:15:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408171518.GA4201@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 10:14:22AM -0700, Linus Torvalds wrote:

> After applying a patch, I can do a complete "show-diff" on the kernel tree
> to see the effect of it in about 0.15 seconds.

How does that work?  Can you stat the entire tree in that time?  I
measure it as being higher than that.
