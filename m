Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTJFWWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 18:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJFWWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 18:22:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:57811 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261874AbTJFWWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 18:22:34 -0400
Date: Mon, 6 Oct 2003 15:30:50 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
In-Reply-To: <20031003223352.GB344@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310061527410.1407-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One thing would help me: could you reply with "Applied" when you apply
> some patch? Just now it seems to be silence==applied and reply==some
> problem, but that makes it "interesting" to guess what your tree looks
> like.

Yes, I'll try to be better about this. 

> At this point, suspend may no longer fail: we have ready-to-run image
> in swap, and rollback would happen on next reboot -- corrupting
> data. Yep better docs is needed.
> 
> How about this one?

Applied.


	Pat

