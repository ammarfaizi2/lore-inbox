Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272193AbRIEOne>; Wed, 5 Sep 2001 10:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272192AbRIEOnY>; Wed, 5 Sep 2001 10:43:24 -0400
Received: from ns1.n-online.net ([195.30.220.100]:46609 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S272191AbRIEOnP>; Wed, 5 Sep 2001 10:43:15 -0400
Date: Wed, 5 Sep 2001 16:36:21 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac6
X-Mailer: Thomas Foerster's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010905144317Z272191-760+9716@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr> writes:

>>Would it not be possible with your scheme to package a closed source driver
>>in an open source wrapper driver and then defeat your tainting technique.

>>Is it legally possible to copyright a kind of magic number with a copyright
>>allowing only it's used in open & public source driver ?

> Congratulations, you've just invented the Microsoft HW Labs
> certification procedure with module signing. ;-)

> I can really see it:

> # insmod <module>
> This module <module> is not signed with the Linus Torvalds Hardware
> Certification Labs key.

> Do you want to

> a) insert the module anyway (Errors and Crashes from your kernel will
> not be processed by major kernel developers
> b) not insert the module
> c) search for an alternative driver that is open source, download it,
>    compile it and use that instead of <module>
> d) download a skeleton driver to write your own driver
> e) install Microsoft Windows XP
> f) exit

> -> f

LOL, that's the point!

What's about : linuxupdate.linux.org

;-)

Thomas

