Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133116AbRDRND4>; Wed, 18 Apr 2001 09:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133117AbRDRNDq>; Wed, 18 Apr 2001 09:03:46 -0400
Received: from denise.shiny.it ([194.20.232.1]:27857 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S133116AbRDRNDe>;
	Wed, 18 Apr 2001 09:03:34 -0400
Message-ID: <XFMail.010418150323.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E14pqzO-0004bp-00@the-village.bc.nu>
Date: Wed, 18 Apr 2001 15:03:23 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: I can eject a mounted CD
Cc: linux-kernel@vger.kernel.org, lna@bigfoot.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> vmware and one or two other apps I've also seen do this. WHen you unlock the
> cdrom door as root you can unlock it even if a file system is mounted

Right, so I'll check what eject(1) does. It might eject the disk even if it
failed to unmount.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

