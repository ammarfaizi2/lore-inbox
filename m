Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284535AbRLPI7G>; Sun, 16 Dec 2001 03:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284536AbRLPI64>; Sun, 16 Dec 2001 03:58:56 -0500
Received: from www.wen-online.de ([212.223.88.39]:28175 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S284535AbRLPI6s>;
	Sun, 16 Dec 2001 03:58:48 -0500
Date: Sun, 16 Dec 2001 10:02:56 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root and initrd kernel panic woes
In-Reply-To: <01121600323100.01820@manta>
Message-ID: <Pine.LNX.4.33.0112160913360.452-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, vda wrote:

> BTW, is it possible for you to place your initrd on some publicly accessible
> ftp/http server?

Point me at an ftp server that will allow put.  Alternately, I can mail
you the .config and image if your mta accepts mondo messages.

I can't imagine how one fs image could load/work and another not unless
maybe your bootloader is screwing up placement.  I use loadlin.

	-Mike

