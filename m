Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTKYCx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 21:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTKYCx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 21:53:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:22470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261930AbTKYCxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 21:53:55 -0500
Date: Mon, 24 Nov 2003 18:52:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: jt@hpl.hp.com
cc: David Hinds <dhinds@sonic.net>, linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <Pine.LNX.4.58.0311241845200.1599@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0311241851480.1599@home.osdl.org>
References: <20031124235727.GA2467@bougret.hpl.hp.com> <20031124162628.A32213@sonic.net>
 <20031125004942.GA3002@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241804560.1599@home.osdl.org>
 <20031125023319.GA3819@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241845200.1599@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Nov 2003, Linus Torvalds wrote:
>
> Can you do a "dump_pirq"?

Oh, and a "lspci -vvxxx" as root too? Along with info on the machine?

		Linus
