Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129744AbQKFUiH>; Mon, 6 Nov 2000 15:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbQKFUh5>; Mon, 6 Nov 2000 15:37:57 -0500
Received: from web110.mail.yahoo.com ([205.180.60.80]:16902 "HELO
	web110.yahoomail.com") by vger.kernel.org with SMTP
	id <S129993AbQKFUhj>; Mon, 6 Nov 2000 15:37:39 -0500
Message-ID: <20001106203738.17935.qmail@web110.yahoomail.com>
Date: Mon, 6 Nov 2000 12:37:38 -0800 (PST)
From: Paul Powell <moloch16@yahoo.com>
Subject: xterm: no available ptys
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have created a trimmed down /dev directory to be
used with my custom bootable Linux CD.  I've run into
a problem where I can't start an xterm.  I get the
error...

xterm:  no available ptys

I'm not sure which device I'm missing in /dev.  I'm no
expert on how the tty's and stuff work so feel free to
fill me in. Everything else seems to work fine on the
CD.

Here is what my /dev directory looks like now:

/dev:
console
cua0
cua1
cua2
cua3
fb
fb0
fb1
fb2
fb3
fb4
fb5
fb6
fb7
fd0
fd1
hda
hdb
hdc
hdd
kmem
listing
mem
mouse
null
psaux
pts
 |...0
ram
ram0
ram1
ram2
ram3
ramdisk
scd0
scd1
scd2
scd3
scd4
scd5
scd6
scd7
tty
tty0
tty1
tty2
ttyp0
ttyp1
ttyp2
ttyp3
ttyp4
urandom
zero

Am I missing something?

Any help appreciated!

__________________________________________________
Do You Yahoo!?
Thousands of Stores.  Millions of Products.  All in one Place.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
