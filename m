Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266626AbSLJFtl>; Tue, 10 Dec 2002 00:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbSLJFtl>; Tue, 10 Dec 2002 00:49:41 -0500
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46]:1154 "EHLO
	grebe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266626AbSLJFtk>; Tue, 10 Dec 2002 00:49:40 -0500
Date: Mon, 9 Dec 2002 22:49:58 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Allan Duncan <allan.d@bigpond.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.51
In-Reply-To: <3DF57FE0.7090300@bigpond.com>
Message-ID: <Pine.LNX.4.33.0212092243260.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The AGP reorg, fbdev merge, and the s390 updates also help make the patch
>                   ^^^^^^^^^^^
> > quite large.
>
> Unfortunately not all went well with this:
>
> drivers/video/matrox/matroxfb_base.h:52:25: video/fbcon.h: No such file or directory
>
> ... and downwards thereafter.

The matrox driver hasn't be ported yet. About 1/2 are now ported to the
final api. Over the following week I will porting a bunch of new drivers.
This is the final changes in the api so drivers can now be ported!!!! If
you need help porting them email me and I'm here to help.

P.S
   I even was donated a SPARC 10 station!!! Thanks Chris!!!

P.S.S

   What I really need is a Radeon card :-)



