Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSBKAxH>; Sun, 10 Feb 2002 19:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSBKAws>; Sun, 10 Feb 2002 19:52:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16392 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285829AbSBKAwf>; Sun, 10 Feb 2002 19:52:35 -0500
Subject: Re: Transaction TCP patch for Linux
To: ahu@ds9a.nl (bert hubert)
Date: Mon, 11 Feb 2002 01:06:04 +0000 (GMT)
Cc: laudney@21cn.com (Laurence), linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20020210205957.A13073@outpost.ds9a.nl> from "bert hubert" at Feb 10, 2002 08:59:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16a4uy-0004zO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > patch for Linux kernel 2.4.2. Is anyone interested in it or have
> > anything to say about T/TCP's pros and cons??
> 
> I've seen people state that T/TCP is fundamentally broken:
> http://groups.google.com/groups?q=alan+cox+%22t/tcp%22&hl=en&scoring=d&selm=linux.kernel.E14vGeS-0005Lu-00%40the-village.bc.nu&rnum=2
> http://www.xent.com/FoRK-archive/feb99/0255.html
> 
> So I'm not sure if it is worth implementing.

T/TCP in its current form is broken. Implementing it is still a fun exercise
for someone, and while nobody has pushed it forwards there is no reason to
believe it can't be fixed. You just have to write T/TCPv2 and draft the
rfc to fix it
