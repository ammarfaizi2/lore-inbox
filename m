Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272317AbTHEAut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272316AbTHEAut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:50:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:33243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272327AbTHEAtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:49:23 -0400
Date: Mon, 4 Aug 2003 17:54:15 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Make suspend less talkative
In-Reply-To: <20030726224335.GA483@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308041753550.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is trivial killing of unneccessary printks. They mess up screen
> badly during suspend. Patrick, some of those are patches to your parts
> of code, so please try to propagate at least them to Linus.

Applied, thanks.


	-pat

