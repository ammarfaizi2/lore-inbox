Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263240AbSJFCvz>; Sat, 5 Oct 2002 22:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263253AbSJFCvz>; Sat, 5 Oct 2002 22:51:55 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:39390 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S263240AbSJFCvy>; Sat, 5 Oct 2002 22:51:54 -0400
Message-ID: <001001c26ce4$15e49380$0a00a8c0@refresco>
From: "John Tyner" <jtyner@cs.ucr.edu>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.30.0210032047510.15999-400000@hill.cs.ucr.edu> <20021004045051.GB3556@kroah.com>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Sat, 5 Oct 2002 19:57:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you send me a patch for 2.5, I'd be glad to add it to the tree.

As promised, here is a patch against 2.5.40.

The 2.5 V4L interface looks like it will provide a way for multiple users to
use the same camera simultaneously, but that's a fairly drastic change, and
I'd like to start with something that is pretty well tested [at least by
me]. So, this patch is a sraight forward-port of the 2.4 version posted a
few days ago.

> Right now, I'm not accepting USB drivers that don't show up in 2.5
> first.

If desired, I'll create a patch of the 2.4 version as well.

Thanks,
John

