Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRJET5r>; Fri, 5 Oct 2001 15:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRJET5j>; Fri, 5 Oct 2001 15:57:39 -0400
Received: from ares.sot.com ([195.74.13.236]:49419 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id <S271741AbRJET5U>;
	Fri, 5 Oct 2001 15:57:20 -0400
Date: Fri, 5 Oct 2001 22:57:39 +0300 (EEST)
From: Yaroslav Popovitch <yp@sot.com>
To: Per Persson <per.persson@gnosjo.pp.se>
cc: linux-kernel@vger.kernel.org
Subject: RE:[PATCH] triple_down in fs.h
Message-ID: <Pine.LNX.4.10.10110052242150.17293-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi! I aplied you patch to kernel-2.4.10 and tried to compile it.But during
compiling got error,which was caused by double definition of sort. It is
already in scsi/u14-34f.c,function with 4 parameters,declared as static.
As your #define sort is used only in fs.h,so I renamed it by adding some
symbols to name for ex. _sort,or hihahasort,(that is joke :)

Cheers,YP


