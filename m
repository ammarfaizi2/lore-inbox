Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbTJTTcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTJTTcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:32:16 -0400
Received: from [65.172.181.6] ([65.172.181.6]:32938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262755AbTJTTcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:32:14 -0400
Date: Mon, 20 Oct 2003 12:41:20 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Strange cleanups in -test8 kernel/acpi/wakeup.S
In-Reply-To: <20031020193100.GB540@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310201240560.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One was test "is stack working or do we get fault", and second was "do
> our page tables look reasonable". I was not trying to pause.
> 
> Anyway it was undocumented and it was hack. Best thing is probably to
> kill it. Here's a patch.

Ah, I see. Will apply patch.

Thanks,


	Pat

