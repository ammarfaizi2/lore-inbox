Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130094AbRCERs2>; Mon, 5 Mar 2001 12:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRCERsI>; Mon, 5 Mar 2001 12:48:08 -0500
Received: from www.wen-online.de ([212.223.88.39]:24588 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130094AbRCERr6>;
	Mon, 5 Mar 2001 12:47:58 -0500
Date: Mon, 5 Mar 2001 18:47:08 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loop stuck in -D state
In-Reply-To: <Pine.LNX.3.95.1010305122756.1098A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0103051844390.407-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Richard B. Johnson wrote:

> I tried Linux 2.4.2
> Now I'm in a load of trouble. I can't make a boot-disk to get back
> to 2.4.1 because I use initrd for my hard disk modules and the loop
> device is broken.

What's wrong with 2.4.2 that makes you want to go back?  Anyway, if
you grab Jens' patch, all will be peachy (at least for that kind of
basic usage).

	-Mike

