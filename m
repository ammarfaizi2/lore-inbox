Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290370AbSBKUkv>; Mon, 11 Feb 2002 15:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290361AbSBKUka>; Mon, 11 Feb 2002 15:40:30 -0500
Received: from echo.sound.net ([205.242.192.21]:35486 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S290344AbSBKUkY>;
	Mon, 11 Feb 2002 15:40:24 -0500
Date: Mon, 11 Feb 2002 14:39:47 -0600 (CST)
From: Hal Duston <hald@sound.net>
To: linux-kernel@vger.kernel.org
cc: vojtech@suse.cz
Subject: Re: Input w/2.5.3-dj3
Message-ID: <Pine.GSO.4.10.10202111430440.12270-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got CONFIG_INPUT_KEYBDEV=y in my .config so I am assuming yes.
The keypresses don't generate the correct characters.  I.e. as far as
I can tell, the 'm' key is Caps Lock, the '9' key is ScrLk, the '0'
key is NumLk, the 'q' key is 'y', the 'w' key is Ctrl, the 'e' key is 
'j' the 'r' key is 'x'.  Etc.  I hope you don't need a complete list!

Thanks,
Hal Duston
hald@sound.net


