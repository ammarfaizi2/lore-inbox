Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318000AbSGLUF6>; Fri, 12 Jul 2002 16:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318001AbSGLUF5>; Fri, 12 Jul 2002 16:05:57 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16378 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318000AbSGLUF5>; Fri, 12 Jul 2002 16:05:57 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207121957.g6CJvXLs018439@burner.fokus.gmd.de>
References: <200207121957.g6CJvXLs018439@burner.fokus.gmd.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jul 2002 22:17:21 +0100
Message-Id: <1026508641.9915.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 20:57, Joerg Schilling wrote:
> If you are unable to use arguments, I cannot take you for serious.
> Please educate yourself about SCSI and ATAPI, this would help a lot
> haveing a serious discussion.

Unlike you I've bothered not only to learn about ATA, ATAPI and SCSI but
also to experience real world hardware, much of it less than ten years
old and some of which (especially in the USB world) can't even get
INQUIRY right let alone actually do I/O properly.

CD burning is a side issue to stability and reliability. 

In terms of supporting old hardware most of that is irrelevant to cd
recording anyway, so why do you care ? What you actually need is a
generic interface for cd packet sending.

