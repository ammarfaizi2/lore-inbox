Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317613AbSFMOJE>; Thu, 13 Jun 2002 10:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317614AbSFMOJD>; Thu, 13 Jun 2002 10:09:03 -0400
Received: from www.transvirtual.com ([206.14.214.140]:3342 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317613AbSFMOJC>; Thu, 13 Jun 2002 10:09:02 -0400
Date: Thu, 13 Jun 2002 07:08:45 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.5.21 no source for several objects
In-Reply-To: <8028.1023759039@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0206130707100.17419-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> drivers/video/Makefile
> obj-$(CONFIG_FBCON_IPLAN2P16)     += fbcon-iplan2p16.o

I never seen that come to be. Geert any ideas on this? Since we are
switching to the new api then the iplan stuff will be replaced eventually.
Do we just remove it in this case.

