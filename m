Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbSJOGxO>; Tue, 15 Oct 2002 02:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSJOGxN>; Tue, 15 Oct 2002 02:53:13 -0400
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262750AbSJOGxJ>;
	Tue, 15 Oct 2002 02:53:09 -0400
Date: Mon, 14 Oct 2002 18:30:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] IDE driver model update
Message-ID: <20021014183010.A585@elf.ucw.cz>
References: <Pine.LNX.4.44.0210091131360.16276-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210091131360.16276-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    The suspend/resume callbacks in ide-disk.c have been temporarily
>    disabled until the ide core implements generic methods which forward
>    the calls to the drive drivers. 

Do you have patches to implement this?
								Pavel
-- 
When do you have heart between your knees?
