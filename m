Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318046AbSGWMjE>; Tue, 23 Jul 2002 08:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318057AbSGWMjE>; Tue, 23 Jul 2002 08:39:04 -0400
Received: from ns1.systime.ch ([194.147.113.1]:18437 "EHLO mail.systime.ch")
	by vger.kernel.org with ESMTP id <S318046AbSGWMjC>;
	Tue, 23 Jul 2002 08:39:02 -0400
From: "Martin Brulisauer" <martin@uceb.org>
To: "Oliver Pitzeier" <o.pitzeier@uptime.at>
Date: Tue, 23 Jul 2002 14:42:03 +0200
Subject: RE: kbuild 2.5.26 - arch/alpha
CC: linux-kernel@vger.kernel.org
Message-ID: <3D3D6B3B.25754.1392D3FD@localhost>
In-reply-to: <001101c230d7$c5973c40$1211a8c0@pitzeier.priv.at>
References: <200207211354.g6LDsADU005586@alder.intra.bruli.net>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jul 2002, at 18:57, Oliver Pitzeier wrote:
> Oh... I did... :o( :o) But it's currently a mission
> impossible. The last kernel running fine for my alpha
> is 2.5.18 (with a lot of patches...)
>
> I'm also currently not sure that kernel 2.6.X will
> ever run on alpha. There are not very much alpha-users.
> And there are lesser alpha kernel maintainers.
> Ivan Kokshaysky and "Thunder from the hill" are two
> persons who often work an the Alpha Code. And me
> as well (a bit....). But it's currently not easy
> to fix the new errors (for alpha) in every kernel
> release, because they are growing...

Do you think it's worth the time to patch the current
version? Will Linus apply the patch so we will hopefully
have a 2.6.x kernel that compiles (at least) on alpha's?

Is there anybody who is willing to test such a patch
on different alpha's (I only have some XLT's, an AS800
and one AS250, so all alcor based systems with
ISA and PCI but without EISA and all are using sys_alcor.c)?
Further I can't test SMP with this _very_ old hardware.


Regards,
Martin Brulisauer

