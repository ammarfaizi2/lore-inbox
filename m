Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbUL2ANz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUL2ANz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 19:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUL2ANy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 19:13:54 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:57745 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261254AbUL2ANq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 19:13:46 -0500
Date: Wed, 29 Dec 2004 01:09:30 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: 2.6.10 - Incorrect return from PCI ide controller
Message-ID: <20041229000930.GB18525@electric-eye.fr.zoreil.com>
References: <1104158258.20952.44.camel@localhost.localdomain> <20041228205553.GA18525@electric-eye.fr.zoreil.com> <58cb370e04122813152759d94f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e04122813152759d94f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> :
[...]
> Yes.  Patches welcomed.

First cut available at: 
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-bk1/ata/patches/

Modular compile seems fine. I'll rediff against Alan's patch from 2
minutes ago, add a few comments and do some more work when the Sandman
will be gone.

--
Ueimor
