Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbUK3IUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbUK3IUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUK3IUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:20:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9179 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262018AbUK3ITr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:19:47 -0500
Date: Tue, 30 Nov 2004 09:19:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Marc Leeman <marc.leeman@gmail.com>
cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] number of rd's in Kconfig
In-Reply-To: <1f729c4804112502595b98ed08@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0411300917010.18635@yvahk01.tjqt.qr>
References: <1f729c4804112502595b98ed08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In dedicated systems or small systems; the number of required ramdisks
>is by default (16) too large. Like the size of the ramdisks; these
>patches add that the number of rds can be configured in the kernel
>configuration.
>
>These patches are against the 2.6.9

The last time I checked my kernel tree (it's a suse, but nevermind),
I was able to freely choose the ramdisk size, i.e. there is an input field for
a number.
I have not seen some number field to specify the _number_ of disks, though!


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
