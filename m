Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTJ0Web (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTJ0Web
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:34:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:16058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263628AbTJ0Web (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:34:31 -0500
Date: Mon, 27 Oct 2003 14:43:01 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
In-Reply-To: <20031023234019.GB714@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310271442430.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Okay, suspend is currently not supported on SMP, but we should play it
> safe. What about this one? [Compile tested only, have to get some sleep.]

Applied, thanks.


	Pat

