Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266830AbRGHKwR>; Sun, 8 Jul 2001 06:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266831AbRGHKwI>; Sun, 8 Jul 2001 06:52:08 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:63961 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S266830AbRGHKvy>;
	Sun, 8 Jul 2001 06:51:54 -0400
Message-Id: <m15JCAJ-000P07C@amadeus.home.nl>
Date: Sun, 8 Jul 2001 11:51:51 +0100 (BST)
From: arjan@fenrus.demon.nl
To: rjd@xyzzy.clara.co.uk (Robert J.Dunlop)
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010708104255.B1441@xyzzy.clara.co.uk>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010708104255.B1441@xyzzy.clara.co.uk> you wrote:

> I guess this'll still pickup Sony desktops.
> Perhaps we need a survey of lspci -nv results for sony and non-sony
> machines ?

The DMI table might be bettur up to this job instead...
