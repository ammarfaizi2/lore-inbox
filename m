Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKHA4y>; Tue, 7 Nov 2000 19:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129678AbQKHA4e>; Tue, 7 Nov 2000 19:56:34 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46599 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129210AbQKHA42>; Tue, 7 Nov 2000 19:56:28 -0500
Message-ID: <3A08A3D0.DCBC38B0@timpanogas.org>
Date: Tue, 07 Nov 2000 17:52:32 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: David Relson <relson@osagesoftware.com>, linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.30.0011080047260.10874-100000@space.comunit.de> <4.3.2.7.2.20001107191239.00bb6ea0@mail.osagesoftware.com> <3A089D16.E385FC76@timpanogas.org> <3A08A36D.80DAE0A4@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik wrote:
> 
> Jeff Merkey wrote:
> > The PE model uses flags to identify CPU type and capbilities
> 
> So does ELF.

Jeff,

Can we also combine mutiple segments from different processors or is it
a one-sy two-sy king of affair?  If so, we're there, it just becomes a
linking option.

I am building the RPM for Ute Linux with 2.4.0-10 and right now, I have
to do what RedHat does, and create the /config "directory from hell"
with two dosen .config files and create multiple RPMs for each kernel
(i.e. i586, .i686).  It's too convoluted and customers hate it.

8)

Jeff

> 
> --
> Jeff Garzik             | "When I do this, my computer freezes."
> Building 1024           |          -user
> MandrakeSoft            | "Don't do that."
>                         |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
