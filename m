Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbRGMKl1>; Fri, 13 Jul 2001 06:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbRGMKlR>; Fri, 13 Jul 2001 06:41:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55568 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266999AbRGMKlL>; Fri, 13 Jul 2001 06:41:11 -0400
Subject: Re: Again: Linux 2.4.x and AMD Athlon
To: puckwork@madz.net (Thomas Foerster)
Date: Fri, 13 Jul 2001 11:42:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010713070503Z266936-720+1911@vger.kernel.org> from "Thomas Foerster" at Jul 13, 2001 09:00:54 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15L0OZ-0007iY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My BIOS is the latest release.
> I've just phoned with Epox here in Germany and they told me, that their boards
> are testet with linux and they are working.

They dont test with Athlon optimisations on . ;)

> NOTE : Things are ONLY crashing when being NOT root!!

Thats important.

>        If i log in as root i can't get KDE/Gnome apps to crash, only when i'm a
>        "normal" user! Opening xterm as normal user, su-ing to root and starting 
>        applications works too!

Do you get random crashes or actual logged kernel oopses. Also what X server

> I'm very, very, very confused!

The kernel isnt known for a tendancy to oops according to user id, so me too

