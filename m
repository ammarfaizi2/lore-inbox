Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317477AbSFHXoL>; Sat, 8 Jun 2002 19:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317479AbSFHXoK>; Sat, 8 Jun 2002 19:44:10 -0400
Received: from mail.interware.hu ([195.70.32.130]:29352 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP
	id <S317477AbSFHXoK>; Sat, 8 Jun 2002 19:44:10 -0400
Date: Sun, 9 Jun 2002 01:44:01 +0200
From: DP <dani@apaczai.rulez.org>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre10-ac2 tulip.o
Message-ID: <20020608234400.GA5542@mx3.roons.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-Operating-System: Debian GNU/Linux 2.2 potato
X-System: Cx486SLC - kernel 2.2.21
X-Server: mx3.roons.dyndns.org
X-Organization: choma co. - http://tokmindegy.mine.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

 i compiled kernel 2.4.19-pre10-ac2 with the tulip.o module
(Linux Tulip driver version 0.9.15-pre11 (May 11, 2002))
but i've problems with it. it recognizes the card, and ifconfig
shows it, but i can not ping/dhcp/whatever.

debian gnu/linux woody fresh install. the old driver in 2.2.20 (debian kernel)
works just fine. (tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov)

is it me or the module? :)

-- 
       daniel path * choma co.
    http://www.roons.dyndns.org
