Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVAXQts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVAXQts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVAXQts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:49:48 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:45718 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261530AbVAXQth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:49:37 -0500
Subject: Re: Bug report : drivers/net/hamradio/Kconfig
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: 2df@tuxfamily.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1218.213.228.36.71.1106293102.squirrel@webmail.tuxfamily.org>
References: <1218.213.228.36.71.1106293102.squirrel@webmail.tuxfamily.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106511385.6154.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 15:45:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-21 at 07:38, 2df@tuxfamily.org wrote:
> Hello, i'm translating some Kconfig files to french for the kernelFR
> project (http://kernelfr.traduc.org), and while i was reading
> drivers/net/hamradio/Kconfig
> The kernel is 2.6.10
> 
> In section : "Baycom ser12 halfduplex driver for AX.25" 9th section, in
> the 3rdline, there is :
> "The driver supports the ser12 design in full-duplex mode." instead of
> "half-duplex mode."

That looks like a bug in the original. I'll double check it, or you
could send a patch yourself to the trivial patch maintainer.

