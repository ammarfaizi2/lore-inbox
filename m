Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271515AbTGQRsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271523AbTGQRsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:48:19 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:55815 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271515AbTGQRsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:48:18 -0400
Date: Thu, 17 Jul 2003 19:03:12 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: "David St.Clair" <dstclair@cs.wcu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1 Vesa fb and Nvidia
In-Reply-To: <1058386396.3710.4.camel@localhost>
Message-ID: <Pine.LNX.4.44.0307171902530.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't know if this is a hardware specific bug or I just don't have
> something configured right.
> 
> If I try to boot using vga=792 (which works with 2.4.18) I get a blank
> screen (but hard drive is actively booting). If I don't use vga= at all,
> I get a normal boot without the penguin logo.
> 
> I am using Redhat 9 /w NVidia Geforce 4 420 64Mb.
> 
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_FB=y
> CONFIG_FB_VGA16=y
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_VGA_CONSOLE=y
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y

Where is CONFIG_FRAMEBUFFER_CONSOLE=y ???

