Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUA2Mqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 07:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbUA2Mqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 07:46:37 -0500
Received: from [213.4.129.135] ([213.4.129.135]:55181 "EHLO tnetsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S264310AbUA2Mqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 07:46:36 -0500
From: Xan <DXpublica@telefonica.net>
Reply-To: DXpublica@telefonica.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
Date: Thu, 29 Jan 2004 13:44:25 +0100
User-Agent: KMail/1.5.4
Cc: Kiko Piris <kernel@pirispons.net>,
       Zack Winkles <winkie@linuxfromscratch.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200401270153.12568.DXpublica@telefonica.net> <200401280139.51712.DXpublica@telefonica.net> <Pine.GSO.4.58.0401291305410.8124@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0401291305410.8124@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401291344.25231.DXpublica@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dijous 29 Gener 2004 13:06, en/na Geert Uytterhoeven (<Geert Uytterhoeven 
<geert@linux-m68k.org>>) va escriure:

> On Wed, 28 Jan 2004, Xan wrote:
> > It works finally. I don't know if with vesafb or with radeon, but it
> > works.
>
> Check /proc/fb
>
> Gr{oetje,eeting}s,
>

At finally, with vesafb:
$ cat /proc/fb
0 VESA VGA
$

Thanks for your apportation,
Xan.

