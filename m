Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261905AbTCaXYm>; Mon, 31 Mar 2003 18:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbTCaXYm>; Mon, 31 Mar 2003 18:24:42 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:9991 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261905AbTCaXYl>; Mon, 31 Mar 2003 18:24:41 -0500
Date: Tue, 1 Apr 2003 01:35:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Joel Becker <Joel.Becker@oracle.com>
cc: bert hubert <ahu@ds9a.nl>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030331230720.GP32000@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0304010130590.5042-100000@serv>
References: <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
 <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com>
 <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com>
 <Pine.LNX.4.44.0303281924530.5042-100000@serv> <20030331083157.GA29029@outpost.ds9a.nl>
 <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com>
 <Pine.LNX.4.44.0303312215020.5042-100000@serv> <20030331230720.GP32000@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Mar 2003, Joel Becker wrote:

> 	I'm right here campaigning loudly for a larger dev_t.  I intend
> to never, ever make assumptions about dev_t.  In fact, I'd rather not
> deal with dev_t.  But I do need a way to map 4k or 8k or 16k disks.
> now.

Fine, so write the software to do this, but what exactly is there still 
for the kernel to do?

bye, Roman

