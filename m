Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTLWQiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTLWQiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:38:05 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:44484 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262129AbTLWQiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:38:02 -0500
Date: Tue, 23 Dec 2003 08:39:26 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "Giacomo A. Catenazzi" <cate@pixelized.ch>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: SCO's infringing files list
Message-ID: <20031223163926.GC45620@gaz.sfgoth.com>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com> <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de> <3FE811E3.6010708@debian.org> <Pine.LNX.4.58.0312230317450.12483@home.osdl.org> <3FE862E7.1@pixelized.ch> <20031223160425.GB45620@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223160425.GB45620@gaz.sfgoth.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> | 7. 0.96bp2inc.tar.Z (the kernel header files for 0.96b patch level 2)
> 
> The last file seems to be a modified version of the 0.96bp2 header files
> needed in order to work with the new gcc release (searching for that filename
> turns up a message discussing it a little)

This does seem to be the case - from an FAQ that H J Lu posted about that time:

| From: hlu@yoda.eecs.wsu.edu (H.J. Lu)
| Subject: FAQ about gcc (how to compile program under Linux)
| Date: Sun, 19 Jul 92 06:40:05 GMT
| [...]
| Another file, XXXXinc.tar.Z, where XXXX is the current version number
| of Linux kernel, has all the header files to replace the header files 
| from kernel. YOU MUST INSTALL IT. Please read README for details.

There is some mention of a "GCC channel" where new linux GCC releases got
discussed:

|                       If you want to use the testing release, first
| join the GCC channel on the Linux mailing list, and then send a note to
| hlu@eecs.wsu.edu.

Does anyone know if there's an archive available for that ancient list?
Maybe we can find some discussion WRT errno.h there.

-Mitch
