Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTJIBx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 21:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTJIBx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 21:53:27 -0400
Received: from [66.212.224.118] ([66.212.224.118]:16 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S261875AbTJIBxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 21:53:24 -0400
Date: Wed, 8 Oct 2003 21:53:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Domen Puncer <domen@coderock.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-Reply-To: <200310081705.16241.domen@coderock.org>
Message-ID: <Pine.LNX.4.53.0310082152380.21753@montezuma.fsmlabs.com>
References: <200310061529.56959.domen@coderock.org> <200310070949.31220.domen@coderock.org>
 <Pine.LNX.4.53.0310071349560.19396@montezuma.fsmlabs.com>
 <200310081705.16241.domen@coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, Domen Puncer wrote:

> > Ok in this case it would be the hub, sometimes these aren't the best when
> > it comes to advertising capabilities.
> 
> Also slow on crossover cable, without hub.

Thanks for confirming that.

> Ok, updated to the one that ships with redhat.
> Now i get:
> eth0: link ok
> when it is slow (-test2 module)
> 
> and:
> eth0: negotiated 100baseTx-FD, link ok
> when it is ok (reloaded -test2 module)

What does mii-tool -r do?
