Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbTAMAYy>; Sun, 12 Jan 2003 19:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbTAMAYx>; Sun, 12 Jan 2003 19:24:53 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:52497 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267686AbTAMAYx>; Sun, 12 Jan 2003 19:24:53 -0500
Message-ID: <3E21FF13.DD9B8340@linux-m68k.org>
Date: Mon, 13 Jan 2003 00:49:39 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: make xconfig broken in bk current
References: <200301121512.59840.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This makes sense.  Debian has changed its default compiler to 3.2 in
> sid...  Suspect we will get quite a few reports like this one.
> 
> Solution would seem to be to fix the links in /usr/bin for:

Until qt is recompiled, "make HOSTCXX=g++-2.95 xconfig" should do it.

bye, Roman


