Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290592AbSBXRzQ>; Sun, 24 Feb 2002 12:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290496AbSBXRzH>; Sun, 24 Feb 2002 12:55:07 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:56837 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S290550AbSBXRyy>; Sun, 24 Feb 2002 12:54:54 -0500
Message-Id: <200202241755.g1OHtOI77339@aslan.scsiguy.com>
To: otto.wyss@bluewin.ch
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic: Loop 1 (aic7xxx driver) 
In-Reply-To: Your message of "Sun, 24 Feb 2002 17:49:17 +0100."
             <3C79198D.B4161A96@bluewin.ch> 
Date: Sun, 24 Feb 2002 10:55:24 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Since kernel version 2.4.9 I haven't compiled a kernel until recently. With
>2.4.17

If you are using 2.4.17, apply the patch to upgrade your driver to
version 6.2.5 which corrects this problem:

http://people.FreeBSD.org/~gibbs/linux/

A patch for 2.4.18-rc will be made available as soon as I have a bit
more testing on it - probably tomorrow morning.

--
Justin
