Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291084AbSBVBsw>; Thu, 21 Feb 2002 20:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291081AbSBVBsn>; Thu, 21 Feb 2002 20:48:43 -0500
Received: from [203.94.130.164] ([203.94.130.164]:3849 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S291041AbSBVBsZ>;
	Thu, 21 Feb 2002 20:48:25 -0500
Date: Fri, 22 Feb 2002 13:16:23 +1100 (EST)
From: Brett <brett@bad-sports.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5-dj1 - ide_set_handler/kernel timer
Message-ID: <Pine.LNX.4.44.0202221314280.7163-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

This just popped up a few minutes after boot:

hda: ide_set_handler: handler not null; old=c01c4d30, new=c01c4d30
bug: kernel timer added twice at c01c6197.

*shrug*

	/ Brett

