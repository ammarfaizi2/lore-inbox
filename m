Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQKFUzy>; Mon, 6 Nov 2000 15:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKFUzo>; Mon, 6 Nov 2000 15:55:44 -0500
Received: from site3.talontech.com ([208.179.68.88]:61231 "EHLO
	site3.talontech.com") by vger.kernel.org with ESMTP
	id <S129043AbQKFUze>; Mon, 6 Nov 2000 15:55:34 -0500
Message-ID: <3A071A63.1B2B910D@talontech.com>
Date: Mon, 06 Nov 2000 12:53:55 -0800
From: Ben Ford <bford@talontech.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Powell <moloch16@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: xterm: no available ptys
In-Reply-To: <20001106203738.17935.qmail@web110.yahoomail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(ben@qwerty)-(12:52pm Mon Nov  6)-(/dev)
$ ls ptys*
ptys0  ptys2  ptys4  ptys6  ptys8  ptysa  ptysc  ptyse
ptys1  ptys3  ptys5  ptys7  ptys9  ptysb  ptysd  ptysf


-b

Paul Powell wrote:

> Hello,
>
> I have created a trimmed down /dev directory to be
> used with my custom bootable Linux CD.  I've run into
> a problem where I can't start an xterm.  I get the
> error...
>
> xterm:  no available ptys
>
> I'm not sure which device I'm missing in /dev.  I'm no
> expert on how the tty's and stuff work so feel free to
> fill me in. Everything else seems to work fine on the
> CD.
>
> Here is what my /dev directory looks like now:
>
> /dev:
> console
> cua0
> cua1
> cua2
> cua3
> fb
> fb0
> fb1
> fb2
> fb3
> fb4
> fb5
> fb6
> fb7
> fd0
> fd1
> hda
> hdb
> hdc
> hdd
> kmem
> listing
> mem
> mouse
> null
> psaux
> pts
>  |...0
> ram
> ram0
> ram1
> ram2
> ram3
> ramdisk
> scd0
> scd1
> scd2
> scd3
> scd4
> scd5
> scd6
> scd7
> tty
> tty0
> tty1
> tty2
> ttyp0
> ttyp1
> ttyp2
> ttyp3
> ttyp4
> urandom
> zero
>
> Am I missing something?
>
> Any help appreciated!
>
> __________________________________________________
> Do You Yahoo!?
> Thousands of Stores.  Millions of Products.  All in one Place.
> http://shopping.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
