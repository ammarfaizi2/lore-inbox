Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266132AbRGDSxv>; Wed, 4 Jul 2001 14:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266133AbRGDSxl>; Wed, 4 Jul 2001 14:53:41 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:39311 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S266132AbRGDSx0>; Wed, 4 Jul 2001 14:53:26 -0400
Subject: >128 MB RAM stability problems (again)
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 04 Jul 2001 22:45:24 +0200
Message-Id: <994279551.1116.0.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

you might remember an e-mail from me (two weeks ago) with my problems
where linux would not boot up or be highly instable on a machine with
256 MB RAM, while it was 100% stable with 128 MB RAM. Basically, I still
have this problem, so I am running with 128 MB RAM again.

I've been running Mandrake 7.2 on another machine for some time - no
problem, until..... I added another 64 MB RAM and tried to install
redhat (25 times (!!!)) and Mandrake 8.0... Both crash with memory
faults..... Redhat just freezes or givesa a python warning, Mandrake
gives a segfault with a warning that "memory is missing".... Both refuse
to complete installation...

I'm kind of astounded now, WHY can't linux-2.4.x run on ANY machine in
my house with more than 128 MB RAM?!? Can someone please point out to me
that he's actually running kernel-2.4.x on a machine with more than 128
MB RAM and that he's NOT having severe stability problems?
And can that same person PLEASE point out to me why 2.4.x is crashing on
me (or help me to find out...)?

First machine is a Intel P-II 400 with 128 MB RAM (133 MHz SDRAM) and
crashing when I insert an additional 128 - it's running RH-7.0 with
kernel-2.4.4. Second machine is an AMD Duron 600 with 196 MB RAM (also
133 MHz SDRAM), crashing during the installation of both Mandrake 8.0
and Redhat 7.1 and which used to run stable with 128 MB RAM or 64 MB RAM
with Mandrake-7.2. Win2k runs stable on this machine in all
configurations.

I'm getting desperate.... win2k is running stable and it's scary to see
linux crash while win2k runs stable and smooth.

(ps I'm not subscribed to the list - please CC a copy to me when
replying)

Thanks in advance for any help on this,

--
Ronald Bultje

