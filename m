Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTA1KdB>; Tue, 28 Jan 2003 05:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTA1KdA>; Tue, 28 Jan 2003 05:33:00 -0500
Received: from mail2.webart.de ([195.30.14.11]:13843 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S265074AbTA1Kc5>;
	Tue, 28 Jan 2003 05:32:57 -0500
Message-ID: <398E93A81CC5D311901600A0C9F29289469375@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'John Bradford'" <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: AW: AW: Bootscreen
Date: Tue, 28 Jan 2003 11:33:00 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a boot option to do this, but I can't remember what it is :-)
What you mean, I believe, is "quiet".

> LILO loading linux...
> Uncompressing the kernel...
Yeah, these can be easily supressed, somewhere in arch/i386/boot/compressed

Are you in effect saying that Linux is *not* reinitializing the display,
but the bootloader is? That would be interesting, I'd have to write some-
where else :P
