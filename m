Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbTEVFLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 01:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbTEVFLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 01:11:37 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:29824
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262483AbTEVFLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 01:11:37 -0400
Date: Thu, 22 May 2003 01:14:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dima Brodsky <dima@cs.ubc.ca>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69 doesn't boot
In-Reply-To: <20030522050427.GA9191@columbia.cs.ubc.ca>
Message-ID: <Pine.LNX.4.50.0305220113001.30977-100000@montezuma.mastecende.com>
References: <20030522050427.GA9191@columbia.cs.ubc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003, Dima Brodsky wrote:

> 2.5.69 won't boot on a:
> 
> PIII 650, 512 Ram, 440 BX chipset (Asus board)
> GeForce 256 vga
> D-Link DFE-538TX (RealTek RTL8139) network card
> Tekram DC395U/UW/F DC315/U V1.41, 2002-06-21 scsi card for scanner

'If a Linux box boots but you don't see the kernel output, did it really 
boot? ;)'

Turn on CONFIG_VT

	Zwane

