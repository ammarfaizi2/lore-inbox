Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSLHKha>; Sun, 8 Dec 2002 05:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbSLHKha>; Sun, 8 Dec 2002 05:37:30 -0500
Received: from [66.70.28.20] ([66.70.28.20]:25619 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265336AbSLHKh3>; Sun, 8 Dec 2002 05:37:29 -0500
Date: Sun, 8 Dec 2002 11:33:16 +0100
From: DervishD <raul@pleyades.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unable to boot a raw kernel image :??
Message-ID: <20021208103316.GA135@DervishD>
References: <20021129132126.GA102@DervishD> <200212030640.gB36dhp09194@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200212030640.gB36dhp09194@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Denis :)

> >     After that, mkisofsing, toasting and booting. But now, depending
> > on the machine,                                            ^^^^^^^^^
>   ^^^^^^^^^^^^^^
> Boot CD support is BIOS-dependent AFAIK. Maybe on those machines BIOS
> floppy emulation from CD is broken?

    Not at all. I can boot using isolinux (or syslinux), for example.
The failure happens in all machines I've tested, but depending on the
machine, the particular fail is one or another: some of them
generate 'invalid compressed format', others just hang, etc...

    But booting the same kernel using isolinux works :( That is, it
is not a mkisofs issue, nor a cdrecord issue, etc...

    Thanks for your answer, Denis :)
    Raúl
