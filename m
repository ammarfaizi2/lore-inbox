Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTJIXKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 19:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbTJIXKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 19:10:41 -0400
Received: from [66.212.224.118] ([66.212.224.118]:17937 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S262324AbTJIXKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 19:10:39 -0400
Date: Thu, 9 Oct 2003 19:10:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Domen Puncer <domen@coderock.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-Reply-To: <200310091049.18595.domen@coderock.org>
Message-ID: <Pine.LNX.4.53.0310091904400.3679@montezuma.fsmlabs.com>
References: <200310061529.56959.domen@coderock.org> <200310081705.16241.domen@coderock.org>
 <Pine.LNX.4.53.0310082152380.21753@montezuma.fsmlabs.com>
 <200310091049.18595.domen@coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Domen Puncer wrote:

> > > eth0: negotiated 100baseTx-FD, link ok
> > > when it is ok (reloaded -test2 module)
> >
> > What does mii-tool -r do?
> 
> Doesn't help, neither do -R or -F.

Ok to recap, backing out the WOL change fixes things? If not, can you 
isolate which kernel version it is?

Thanks

