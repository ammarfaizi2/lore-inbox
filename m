Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263017AbTC1Pir>; Fri, 28 Mar 2003 10:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263018AbTC1Pir>; Fri, 28 Mar 2003 10:38:47 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:12046 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263017AbTC1Piq>; Fri, 28 Mar 2003 10:38:46 -0500
Date: Fri, 28 Mar 2003 16:49:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <UTC200303281533.h2SFXPP00799.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303281641400.5042-100000@serv>
References: <UTC200303281533.h2SFXPP00799.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> I would prefer if you waited a bit. This little detail,
> changing the size of dev_t, requires an audit of the
> kernel source. That takes some time.
> I would much prefer postponing discussion about device
> handling until after number handling is in good shape.

You already changed the device handling and you don't want to discuss it? 
My patch does the same without the questionable device handling changes.

> Generally it is a bad idea when two people simultaneously
> change the same code.

Ignoring other people's comments and questions is generally a bad idea as 
well.

bye, Roman

