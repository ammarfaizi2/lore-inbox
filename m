Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbSKLKDS>; Tue, 12 Nov 2002 05:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266461AbSKLKDS>; Tue, 12 Nov 2002 05:03:18 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:28602 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266460AbSKLKDR>; Tue, 12 Nov 2002 05:03:17 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 12 Nov 2002 12:11:48 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: linux-kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: second error, bttv 2.5.47
Message-ID: <20021112111148.GC24454@bytesex.org>
References: <1036990995.24251.7.camel@flat41> <slrnasva6g.c13.kraxel@bytesex.org> <1037058270.15197.2.camel@flat41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037058270.15197.2.camel@flat41>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In file included from drivers/media/video/zr36120.c:43:

zoran needs a major update (the zoran people are working on it ...)

> drivers/media/video/saa7111.c:37: linux/i2c-old.h: No such file or
> directory

I've seen patches for this one on the list recently.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
