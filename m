Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVITMf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVITMf0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVITMf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:35:26 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38086 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964995AbVITMfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:35:25 -0400
Date: Tue, 20 Sep 2005 15:35:11 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <20050920123149.GA29112@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509201533450.11074@sbz-30.cs.Helsinki.FI>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <84144f0205092004187f86840c@mail.gmail.com> <20050920114003.GA31025@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
 <20050920123149.GA29112@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Russell King wrote:
> No matter, and no matter what CodingStyle says, I won't be changing
> my style of kmalloc for something which I disagree with.

Ack. No need to clutter Coding Style on things that people won't follow.

			Pekka
