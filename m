Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbSLKEW4>; Tue, 10 Dec 2002 23:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbSLKEW4>; Tue, 10 Dec 2002 23:22:56 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:33409 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266998AbSLKEW4>; Tue, 10 Dec 2002 23:22:56 -0500
Date: Tue, 10 Dec 2002 21:23:40 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Willem Riede <wrlk@riede.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: drivers/video/sis horribly broken in 2.5.51
In-Reply-To: <20021211033312.GN3664@linnie.riede.org>
Message-ID: <Pine.LNX.4.33.0212102029180.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linux 2.5.51 appears to have horribly broken the files in
> drivers/video/sis. linux-2.5.51/drivers/video/sis/sis_main.c
> refers to #include <video/fbcon.h>, <video/fbcon-cfb8.h>,
> <video/fbcon-cfb16.h>, <video/fbcon-cfb24.h>, <video/fbcon-cfb32.h>
> which appears to have been removed from the tree. And who knows
> what other havoc has been created :-(
>
> Does anyone know how to fix this?

The author is working on updating the driver. I talked it him some time
ago and he wanted to wait until the merge happened. In fact alot of driver
maintainers wanted to wait until the merged. So you will started to see
several broken drivers start to work.




