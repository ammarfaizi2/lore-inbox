Return-Path: <linux-kernel-owner+w=401wt.eu-S1754841AbXABNun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbXABNun (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 08:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbXABNun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 08:50:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57586 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754841AbXABNun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 08:50:43 -0500
Date: Tue, 2 Jan 2007 14:00:43 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Alessandro Suardi" <alessandro.suardi@gmail.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
Message-ID: <20070102140043.29a59840@localhost.localdomain>
In-Reply-To: <5a4c581d0701020407w7c0c768bk7ce3ab2d2d7f19f5@mail.gmail.com>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	<459973F6.2090201@pobox.com>
	<20070102115834.1e7644b2@localhost.localdomain>
	<5a4c581d0701020407w7c0c768bk7ce3ab2d2d7f19f5@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Appears to work just fine here (compiles, boots and I'm
>  typing this email :).  The build warnings below seem new
>  to me - but I guess they're harmless...

They are harmless. For the 2.6.21 code base they will go away as well.
