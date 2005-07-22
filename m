Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVGVSaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVGVSaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVGVSaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:30:07 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:23428 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261377AbVGVS3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:29:06 -0400
Date: Fri, 22 Jul 2005 20:28:54 +0200
From: Voluspa <lista1@telia.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: jesper.juhl@gmail.com, lista1@telia.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-Id: <20050722202854.0b7ff7fc.lista1@telia.com>
In-Reply-To: <20050722180236.GA615@atrey.karlin.mff.cuni.cz>
References: <20050721200448.5c4a2ea0.lista1@telia.com>
	<9a8748490507211114227720b0@mail.gmail.com>
	<20050722144855.GA2036@elf.ucw.cz>
	<20050722191510.5e120515.voluspa@telia.com>
	<20050722180236.GA615@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005 20:02:36 +0200 Pavel Machek wrote:
> Okay, if you have no C2/C3 like the dump above shows, unloading usb
> will not help. It seems like your machine is simply not able to do
> reasonable powersaving.

Because of the CPU, ACPI implementation or because of kernel acpi
quality, x86_64 kernel quirks or...? It seems crazy that a modern CPU
like this should be so backwards as to not implement sleep states. It
being in a notebook and all. I blame intel kernel hackers ;-)

Mvh
Mats Johannesson
--
