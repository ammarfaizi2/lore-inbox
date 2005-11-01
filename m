Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVKAQsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVKAQsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVKAQsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:48:16 -0500
Received: from c3po.0xdef.net ([217.172.181.57]:20624 "EHLO c3po.0xdef.net")
	by vger.kernel.org with ESMTP id S1750943AbVKAQsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:48:15 -0500
Date: Tue, 1 Nov 2005 17:48:14 +0100
From: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>
To: linux-kernel@vger.kernel.org
Subject: Re: *** glibc detected *** nmap: malloc(): memory corruption: 0x08718a50 ***
Message-ID: <20051101164814.GA2671@0xdef.net>
Mail-Followup-To: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>,
	linux-kernel@vger.kernel.org
References: <021a01c5df04$43d457e0$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <021a01c5df04$43d457e0$0400a8c0@dcccs>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* JaniD++ | 2005-11-01 17:49:43 [+0100]:

>I get this, on my dual-xeon ECC-reg memory system.
>What is this? :-)

Ask Fyodor! This is a glibc issue, who detects a memory corruption.
There _is_ a bug in nmap!

>kernel: 2.6.13
>(everything looks like normal)

No kernel issue! ;-)

>Janos

HGN

