Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUAEXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266008AbUAEXef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:34:35 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:37640 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266009AbUAEXdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:33:19 -0500
Date: Mon, 5 Jan 2004 23:33:15 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Martin Loschwitz <madkiss@madkiss.org>
cc: linux-kernel@vger.kernel.org, <acpi-devel@lists.sourceforge.net>
Subject: Re: ACPI and framebuffer related problems with Linux 2.6.1-rc1
In-Reply-To: <20040101220615.GA1804@minerva.local.lan>
Message-ID: <Pine.LNX.4.44.0401052332330.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Secondly, there also is a framebuffer related problem. I have VesaFB in kern
> and pass 'vga=791' to it at boot time. However, at the time when it switched
> to FB in previous versions of Linux, the screen by now simply stays black. 
> Is this a known problem and if so is a fix available?

First try my new patch.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

If that doesn't work send me your config file.


