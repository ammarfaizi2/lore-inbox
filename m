Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284913AbRLPXYi>; Sun, 16 Dec 2001 18:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284914AbRLPXY2>; Sun, 16 Dec 2001 18:24:28 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:59520 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S284913AbRLPXYS>; Sun, 16 Dec 2001 18:24:18 -0500
To: raul@viadomus.com, rml@tech9.net
Subject: Re: Is /dev/shm needed?
Cc: linux-kernel@vger.kernel.org
Message-Id: <E16FkpA-0001Yw-00@DervishD.viadomus.com>
Date: Mon, 17 Dec 2001 00:36:04 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Robert :))

>> if it's a *real* filesystem? I wasn't sure, since it's implemented
>> thru the page cache.
>Yes, you can mount as many as you like.

    Ok, then :)))) I'm testing /tmp over tmpfs right now. I don't
notice a great improvement in speed. I have plenty of RAM for my box,
and I think that, just as you said, when I'm compiling the contents
of the /tmp are always cached, no matter if using tmpfs or not.

    I'll try with higher loads and more processes trying to fill up
/tmp ;))

>See Documentation/filesystems/tmpfs.txt for more information.

    I'm afraid my 2.4.16 doesn't come with that file :((( My fault,
probably, although I don't remember touching the docs :???

    Thanks a lot for your help :)

    Raúl
