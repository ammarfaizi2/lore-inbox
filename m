Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUAEXsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266035AbUAEXrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:47:46 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:53000 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266020AbUAEXq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:46:57 -0500
Date: Mon, 5 Jan 2004 23:46:43 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Wes Janzen <superchkn@sbcglobal.net>
cc: Thomas Molina <tmolina@cablespeed.com>,
       Norman Diamond <ndiamond@wta.att.ne.jp>, <dan@eglifamily.dnsalias.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <3FF1232E.3070401@sbcglobal.net>
Message-ID: <Pine.LNX.4.44.0401052345510.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Certainly, something has changed, because with 2.6.0-test11 I was 
> running "vga=0x31B video=vesafb:ywrap" and it worked great, whereas now 
> it doesn't work at all with any fb modes.

To my knowledge the code hasn't been touched since then. I have a new 
patch for you to try.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


