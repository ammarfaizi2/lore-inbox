Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSIUKgu>; Sat, 21 Sep 2002 06:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275888AbSIUKgu>; Sat, 21 Sep 2002 06:36:50 -0400
Received: from quechua.inka.de ([212.227.14.2]:30324 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261242AbSIUKgt>;
	Sat, 21 Sep 2002 06:36:49 -0400
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
In-Reply-To: <Pine.LNX.4.10.10209201753310.25090-100000@master.linux-ide.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17shi3-00083J-00@sites.inka.de>
Date: Sat, 21 Sep 2002 12:41:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10209201753310.25090-100000@master.linux-ide.org> you wrote:
> Regardless, it takes (fill in the blank) to boldly ask people to add APIs
> for an industry who is only interested in using and not contributing.

There is more than one industry interested in it. It simply sucks if your
kernel panic only because you remove a SCSI cable. IT also sucks if your
kernel panics only vecause you have a bad block on a Disk.

Companies which build carrier grade Linux Systems (like HP, IBM and SGI _do_
contribute on making Linux an Enterprise System).

So personal I find this project good, and adding the Linux Testing community
is needed. But I dont think that a lot of new APIs is needed in the first
place. (Well, possibly for things like path failover/md somebody needs to
define an actual error handling, like it is done currently), but "debugging"
all drivers by review is needed. On the other hand, the reason this has not
happend just shows us, that it is not trivial to find a second person which
understands hardware's error behaviour.

Greetings
Bernd
