Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290744AbSBGRz4>; Thu, 7 Feb 2002 12:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290745AbSBGRzr>; Thu, 7 Feb 2002 12:55:47 -0500
Received: from echo.sound.net ([205.242.192.21]:31421 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S290744AbSBGRzf>;
	Thu, 7 Feb 2002 12:55:35 -0500
Date: Thu, 7 Feb 2002 11:55:19 -0600 (CST)
From: Hal Duston <hald@sound.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Input w/2.5.3-dj3
Message-ID: <Pine.GSO.4.10.10202071151580.16311-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I have checked my config.  The only item I was missing
was CONFIG_KEYBOARD_XTKBD=y.  I have now added that, and 
still no keyboard activity.  This is a laptop from 1994
or so, so it's not exactly new stuff.  What should I check
next?

Thanks,
Hal Duston
hald@sound.net

