Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264787AbSJOSi7>; Tue, 15 Oct 2002 14:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSJOSi7>; Tue, 15 Oct 2002 14:38:59 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45979 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264787AbSJOSi7>;
	Tue, 15 Oct 2002 14:38:59 -0400
Date: Tue, 15 Oct 2002 11:47:35 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Pavel Machek <pavel@ucw.cz>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] IDE driver model update
In-Reply-To: <20021014183010.A585@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0210151147180.1038-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Oct 2002, Pavel Machek wrote:

> Hi!
> 
> >    The suspend/resume callbacks in ide-disk.c have been temporarily
> >    disabled until the ide core implements generic methods which forward
> >    the calls to the drive drivers. 
> 
> Do you have patches to implement this?

Not yet. Expect them in the next day or so..


	-pat

