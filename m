Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSK2Nyf>; Fri, 29 Nov 2002 08:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbSK2Nyf>; Fri, 29 Nov 2002 08:54:35 -0500
Received: from [66.70.28.20] ([66.70.28.20]:39174 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267044AbSK2Nye>; Fri, 29 Nov 2002 08:54:34 -0500
Date: Fri, 29 Nov 2002 14:21:26 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Unable to boot a raw kernel image :??
Message-ID: <20021129132126.GA102@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    A time ago I was able to generate bootable Linux CD's just by
dd'ing a floppy containing a raw kernel image:

    dd if=/dev/fd0 of=eltorito

    After that, mkisofsing, toasting and booting. But now, depending
on the machine, I have 'invalid compressed format' errors, or even
ye olde register dump when the image was damaged :(

    Booting directly from the floppy works, but booting with that
same image from a CD does not :(( I now I can use LILO, or better
yet, Syslinux or isolinux, but I'm just curious why I cannot boot raw
image-based CD's anymore.

    Anyone knows what's happenning here?
    Raúl
