Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280796AbRKGOK4>; Wed, 7 Nov 2001 09:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280799AbRKGOKq>; Wed, 7 Nov 2001 09:10:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15891 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280796AbRKGOK2>; Wed, 7 Nov 2001 09:10:28 -0500
Subject: Re: Using %cr2 to reference "current"
To: dalecki@evision.ag
Date: Wed, 7 Nov 2001 14:17:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3BE94C55.AE42D67E@evision-ventures.com> from "Martin Dalecki" at Nov 07, 2001 03:59:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161TWH-0004G9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> somehow encouraged by the compiler comparisions between gcc and intel's
> free compiler, which use the register passing for anything local
> to the actual code, where the speed gains are up to 20% im currently

I was under the impression intels compiler was profoundly non-free ?

> quite inclined to do the redo and finish the experiment.
> BTW.> It's not just asm fixpus that have to be done for this
> to work. For example all the c files with -fno-omit-frame-pointer

20% is a nice large number

Alan
