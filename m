Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265258AbUFAWWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUFAWWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUFAWWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:22:24 -0400
Received: from pop.gmx.de ([213.165.64.20]:28835 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265258AbUFAWVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:21:32 -0400
X-Authenticated: #20450766
Date: Tue, 1 Jun 2004 22:26:13 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Marco Fioretti <mfioretti@mclink.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to make cardbus pci1130 work with kernel 2.4?
In-Reply-To: <1.0.2.200405311519.68186@mclink.it>
Message-ID: <Pine.LNX.4.44.0406012213010.4223-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004, Marco Fioretti wrote:

> I am looking for config files, kernel or boot
> options, *anything* to help me to make the cardbus
> bridge TI PCI1130 work with Red hat 9, or anything with
> 2.4 kernel.

If you send me the output of your lspci -xxx, I can try to put together a
script, consisting of several calls to setpci, which you would run before
loading the yenta driver. This is not a kernel issue, so, just mail me
offlist.

Guennadi
---
Guennadi Liakhovetski



