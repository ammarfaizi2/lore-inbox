Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281054AbRKTMcv>; Tue, 20 Nov 2001 07:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281055AbRKTMcc>; Tue, 20 Nov 2001 07:32:32 -0500
Received: from [213.37.2.159] ([213.37.2.159]:11144 "EHLO alcorcon.madritel.es")
	by vger.kernel.org with ESMTP id <S281054AbRKTMcV>;
	Tue, 20 Nov 2001 07:32:21 -0500
To: ebiederm@xmission.com, lm@bitmover.com
Subject: Re: LOBOS (kexec)
Cc: dervishd@jazzfree.com, linux-kernel@vger.kernel.org
Message-Id: <E1669v2-0000Cv-00@DervishD>
Date: Tue, 20 Nov 2001 13:22:28 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <dervishd@jazzfree.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <dervishd@jazzfree.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Larry (or Eric) :)

>> I've been wanting Linux which can boot Linux for a long time.
>I am maintaining a version of this functionality against 2.4.x
>called kexec.  And I plan to work on integration into linux with 2.5.x.
>After the details are worked out I will look at a backport to 2.4.x

    I think that this is a very important point, since will ease the
making of installation disks, etc... Moreover, it will ease the
creation of 'live' linux systems that can do a pretty work detecting
the hardware and the like.

>The hard part is not linux booting linux but the passing of the
>firmware/BIOS tables from one kernel to the next.

    Why?. I mean, I haven't read on this issue in the LOBOS project.
I'm afraid I thought that this was easier than it really is...

>I am doing this a part of the linuxBIOS effort and as such it is just

    I want to take a look at LinuxBIOS.

    Raúl
