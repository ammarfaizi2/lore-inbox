Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbQJ1RYl>; Sat, 28 Oct 2000 13:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131155AbQJ1RYa>; Sat, 28 Oct 2000 13:24:30 -0400
Received: from [63.95.87.168] ([63.95.87.168]:2319 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S131140AbQJ1RYW>;
	Sat, 28 Oct 2000 13:24:22 -0400
Date: Sat, 28 Oct 2000 13:24:21 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Spencer <markster@linux-support.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.0-test9 not Open Source
Message-ID: <20001028132421.A21038@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.21.0010281049300.26640-100000@hoochie.linux-support.net> <E13pYmK-0005QN-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <E13pYmK-0005QN-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Oct 28, 2000 at 05:24:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 05:24:19PM +0100, Alan Cox wrote:
> The authors of the NTFL layer dont place any additional restrictions on your
> use of the code either. They are merely warning you that if you use it in
> some ways you are going to get your ass kicked by a third party. WHats the
> difference, do you want to be sued by M-Systems or sqaushed by Deutsche Telecon

See section 7 of the GPL.

This is similar sort of GPL violation that kept Debian from shipping KDE
because QT was not GPL compatible and there is GPLed code linked to QT in
KDE without obvious explicit permission for the authors of every piece of
GPLed code in KDE.

In this case, Debian (or any organization who isn't big enough not to fear
M-systems) may not ship the standard kernel because it has additional patent
restrictions.

There is a clear ability here for the author of the driver and m-systems to
conspire to retroactively revoke anyones privilege to use, modify, or
distribute the stock kernel because of this code.

It's nice that the potential patent violation is made clear (I'm sure there
are patents that could potentially apply elsewhere in the kernel) but it
doesn't change the fact that the patents fundamentally limit the 'freedom'
of the kernel code.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
