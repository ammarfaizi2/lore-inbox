Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSJVU6D>; Tue, 22 Oct 2002 16:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264906AbSJVU6D>; Tue, 22 Oct 2002 16:58:03 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:14267 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264901AbSJVU6B>; Tue, 22 Oct 2002 16:58:01 -0400
Subject: Re: [PATCH] Mark ide-floppy drives as removeable in ide-probe.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Bristow <paul@paulbristow.net>
Cc: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB5B585.2060105@paulbristow.net>
References: <3DB5B585.2060105@paulbristow.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 22:20:17 +0100
Message-Id: <1035321617.31917.164.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 21:31, Paul Bristow wrote:
> The following patch marks ide-floppy drives as removeable.  devfs and 
> partition handling code needs this to work properly.  Please apply.

Applied

