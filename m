Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbRE2Blx>; Mon, 28 May 2001 21:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbRE2Blo>; Mon, 28 May 2001 21:41:44 -0400
Received: from [209.249.10.20] ([209.249.10.20]:746 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S261987AbRE2Bl3>;
	Mon, 28 May 2001 21:41:29 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 28 May 2001 18:38:46 -0700
Message-Id: <200105290138.SAA01532@baldur.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Cc: aaronl@vitelus.com, acahalan@cs.uml.edu, adam@yggdrasil.com,
        dledford@redhat.com, jas88@cam.ac.uk, linux-kernel@vger.kernel.org,
        lk@tantalophile.demon.co.uk, lm@bitmover.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> = Alan Cox
>>  = lk@tantalophile.demon.co.uk?
>>> = ??

>>> AFAICS, the firmware is just a file served up to the device as needed
>>> - no more a derivative work from the kernel than my homepage is a
>>> derivative work of Apache.
>> 
>> Indeed.  But if you compiled your home page, linked it into Emacs to
>> display on startup, and distributed the binary, the _combination_
>> "Emacs+homepage" binary would be a derived work, and you'd be required
>> to offer source for both parts.

>In which case GNU Emacs violates the GPL by containing a copy of COPYING which
>is more restricted than the GPL. After all it displays copying on a hotkey
>combination

	"M-x describe-copying" just displays the file
/usr/share/emacs/<version>/etc/COPYING.   The emacs binaries do not
contain the text of GPL.

	By the way, if one wanted to #include the text of the GPL,
then, in the specific case of the GPL, one could argue that the
restrictions on modifying the GPL are part of the GPL and, therefore
not further restrictions.  (Even though those restrictions occur before
the "preamble", they're just as binding and removing them would be a
change to the GPL, so they are an existing restriction of the GPL rather
than a further restriction.)

	That said, I have long advocated that authors use
GPL-compatible copying conditions for everything, including plain text,
to facilitate free software effects on platforms that comingle code
and documentation, such as many web pages and some other interactive
media.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
A
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
