Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSLUANT>; Fri, 20 Dec 2002 19:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLUANT>; Fri, 20 Dec 2002 19:13:19 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:944 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261206AbSLUANT>; Fri, 20 Dec 2002 19:13:19 -0500
Message-Id: <200212210021.BAA15952@post.webmailer.de>
Content-Type: text/plain; charset=US-ASCII
From: Christian Seidemann <christian.seidemann@mni.fh-giessen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: vt8235 fix, hopefully last variant
Date: Sat, 21 Dec 2002 01:25:33 +0100
X-Mailer: KMail [version 1.3.2]
References: <20021219112640.A21164@ucw.cz>
In-Reply-To: <20021219112640.A21164@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> Hi!
>
> Can you guys try out this last take on a fix for your ATAPI device
> problems? Applies against clean 2.4.20.
>
> Please report failure/success.
>
> Thanks.

I also tried the vt8235-atapi patch and it works for me.
MSI KT3 Ultra2 mainboard (KT333), vt8235.
LG DVD-ROM DRD-8160B

Thanks
Christian
