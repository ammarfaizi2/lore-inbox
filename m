Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263145AbTCSRCI>; Wed, 19 Mar 2003 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbTCSRCI>; Wed, 19 Mar 2003 12:02:08 -0500
Received: from mail-5.tiscali.it ([195.130.225.151]:41954 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263145AbTCSRCG>;
	Wed, 19 Mar 2003 12:02:06 -0500
Date: Wed, 19 Mar 2003 18:11:47 +0100
From: Mauro Chiarugi <maurochiarugi@tiscali.it>
To: linux-kernel@vger.kernel.org
Subject: Re: problem with pcmcia, pci and hard disk
Message-Id: <20030319181147.21d2b1d2.maurochiarugi@tiscali.it>
In-Reply-To: <1048097045.30751.64.camel@irongate.swansea.linux.org.uk>
References: <20030319173523.745fb4a9.maurochiarugi@tiscali.it>
	<20030319174705.37994a18.maurochiarugi@tiscali.it>
	<1048097045.30751.64.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19 Mar 2003 18:04:06 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> (aka Alan Cox) ha scritto:

> It should never be failing, on 2.4.18 or 2.5.x with ext3. You should
> get log playbacks on a crash and maybe an fsck every 27 if you set the
> checking to run that way.

If i do:

/var/log# grep -ir fsck *

i don't find anything :-(
is it strange, don't you? 

> My first guess is you have something corrupting data - bad memory, bad
> disk, overclocking or of course a software bug that you happen to hit
> and nobody else seems to.

mmmm... my poor new laptop!!! :-/
But there is something strange.. i tried to install debian woody, but
when the installation program starts, my notebook freezes!! So i've
tried knoppix.. and then i've installed it. I'm using it.

> What drivers are you running

I've tried with pcmcia 2.1.33 and now with 3.2.4

thx

--
sracatus
