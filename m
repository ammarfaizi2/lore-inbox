Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTK3Nfe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 08:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTK3Nfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 08:35:34 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:9702 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S261500AbTK3Nfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 08:35:32 -0500
Date: Sun, 30 Nov 2003 14:35:27 +0100 (MET)
From: Sebastiaan <S.Breedveld@ewi.tudelft.nl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: S.Breedveld@ewi.tudelft.nl, <linux-kernel@vger.kernel.org>
Subject: Re: PowerMac floppy (SWIM-3) doesn't compile
In-Reply-To: <200311301125.hAUBPRC4029084@harpo.it.uu.se>
Message-ID: <Pine.GHP.4.44.0311301430150.29980-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 30 Nov 2003, Mikael Pettersson wrote:

> On Sun, 30 Nov 2003 10:19:07 +0100 (MET), Sebastiaan <S.Breedveld@ewi.tudelft.nl> wrote:
> >I am trying to build the 2.6.0-test11 kernel for my PowerMac 7300/166, but
> >the floppy controller doesn't want to compile. I have:
>
> Known problem. Has been reported several times, but the PPC
> maintainers haven't bothered merging the fix yet.
>
> I'm using the patch below since the 2.5.7x kernels.
> (Paul Mackerras' 2.4 swim3 rework forward-ported to 2.5 by me.)
> There's also an "official" powermac tree somewhere which
> includes some swim3 patch, but I don't know if it's the same
> as this one.
>
Thanks, the patch works fine :).

> As for the boot problem you reported, please try a newer gcc
> like 3.2.3 or 3.3.2. I had lots of wierd problems with 2.95.3
> and the 2.4 kernels on ppc before I switched to gcc-3.x.x.
>
I have upgraded to 3.3.2 but the problem remains.

Thanks,
Sebastiaan


--

English written by Dutch people is easily recognized by the improper use of 'In principle ...'

The software box said 'Requires Windows 95 or better', so I installed Linux.

Als Pacman in de jaren '80 de kinderen zo had be?nvloed zouden nu veel jongeren rondrennen
in donkere zalen terwijl ze pillen eten en luisteren naar monotone electronische muziek.
(Kristian Wilson, Nintendo, 1989)


