Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUAEXvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266046AbUAEXsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:48:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:50696 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266008AbUAEXpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:45:02 -0500
Date: Mon, 5 Jan 2004 23:44:58 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
cc: Thomas Molina <tmolina@cablespeed.com>, <dan@eglifamily.dnsalias.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <00d401c3ce7a$a302fd80$98ee4ca5@DIAMONDLX60>
Message-ID: <Pine.LNX.4.44.0401052344130.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are you serious?  It really is true that vga= isn't supposed to work in
> 2.6.0, but there is something to do with RedHat 7.3 which caused vga= to
> continue to work in 2.6.0 with that distro only?  Then why hasn't the vga=
> parameter been removed entirely?

vga= still works with the vesa framebuffer. There is a small bug that is 
causing all the problems.


