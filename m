Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbSJBO7K>; Wed, 2 Oct 2002 10:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263107AbSJBO7J>; Wed, 2 Oct 2002 10:59:09 -0400
Received: from [66.70.28.20] ([66.70.28.20]:57359 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S263167AbSJBO7I>; Wed, 2 Oct 2002 10:59:08 -0400
Date: Wed, 2 Oct 2002 17:03:15 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: About the SCSI generic driver and libscg
Message-ID: <20021002150315.GA46@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    First of all: I *don't* want to feed a troll, I *don't* want a
flamewar. I just want some information ;))

    I've read some information (at <http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/linuxscsi.html>)
and I don't know if it is a bit outdated. I mean: is not possible to
do under Linux+sg what the document suggests? This document shows
some apparent limitations of the SCSI generic driver under Linux,
namely under kernel 2.2.x and 2.3.x. It doesn't refer to 2.4.x, though.

    Namely what I want to know is if CD recording software (or SCSI
software in general) needs libscg. I haven't seen much SCSI software,
just cdrecord (which needs libscg, but well, it has been written by
Joerg ;)), cdrdao (I don't know right now if it needs or not libscg)
and cdparanoia (AFAIK don't use libscg). What I've read someplaces in
the internet is that truly this library has a better SCSI generic
driver (I insist: I *don't* know if this is true, I just don't know a
word about SCSI).

    I'm just curious why this library hasn't been adopted into the
kernel as the SCSI generic driver and if this library is really
needed or is just the vision of Joerg.

    I know that Joerg has a quite particular personality, but I know
too that he is very intelligent and able and writes good software
(specially cdrecord ;)), so is the curiosity.

    For references, both Alan Cox and Douglas Gilbert are cited in
the document I refer above.

    Thanks in advance :)

    Raúl
