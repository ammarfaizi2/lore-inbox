Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVITPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVITPVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVITPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:21:51 -0400
Received: from xenotime.net ([66.160.160.81]:3745 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965033AbVITPVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:21:50 -0400
Date: Tue, 20 Sep 2005 08:21:48 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <Pine.LNX.4.58.0509201533450.11074@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0509200821130.22777@shark.he.net>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <84144f0205092004187f86840c@mail.gmail.com> <20050920114003.GA31025@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
 <20050920123149.GA29112@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0509201533450.11074@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Pekka J Enberg wrote:

> On Tue, 20 Sep 2005, Russell King wrote:
> > No matter, and no matter what CodingStyle says, I won't be changing
> > my style of kmalloc for something which I disagree with.
>
> Ack. No need to clutter Coding Style on things that people won't follow.

Ack.  or don't have concensus on (unless someone wants for force it)

-- 
~Randy
