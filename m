Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTA1Oys>; Tue, 28 Jan 2003 09:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTA1Oyr>; Tue, 28 Jan 2003 09:54:47 -0500
Received: from mail2.webart.de ([195.30.14.11]:13583 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S267174AbTA1Oxy>;
	Tue, 28 Jan 2003 09:53:54 -0500
Message-ID: <398E93A81CC5D311901600A0C9F2928946938B@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'Stefan Reinauer'" <stepan@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: AW: Bootscreen
Date: Tue, 28 Jan 2003 15:53:58 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In vesafb this is different. The video mode is set before 32bit mode is
> entered, then the 32bit part of the kernel just assumes it can paint to
> some memory found attached to the graphics device.
> Still, for painting a bootsplash screen using fbcon, this does not
> matter as all you need is the framebuffer memory.
Well, I believe we had quite some "threads" developing in this thread now,
where I was trying to find any possible solution to fit my needs. This
idea had come up before your pointing out your patch.
