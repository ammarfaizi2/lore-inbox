Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbQKGMaR>; Tue, 7 Nov 2000 07:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbQKGMaH>; Tue, 7 Nov 2000 07:30:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28536 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129704AbQKGM35>; Tue, 7 Nov 2000 07:29:57 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Tue, 7 Nov 2000 12:27:42 +0000 (GMT)
Cc: mj@suse.cz (Martin Mares), alan@lxorguk.ukuu.org.uk (Alan Cox),
        vojtech@suse.cz (Vojtech Pavlik),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        dwmw2@infradead.org (David Woodhouse), goemon@anime.net (Dan Hollis),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A07E085.3661EB6D@evision-ventures.com> from "Martin Dalecki" at Nov 07, 2000 11:59:17 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7qq-0007Lo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Plese add power-saving devices like in notebooks to the list as well.
> For example in my notebook the PC speaker loops through the maestro-3e.
> The BIOS is initializing the maestro with some sane mixer values but
> after
> a suspend cycle the pc speaker is compleatly off due to suspension of
> the

Then you APM bios is not to specification. Don't inflict your bios bugs on
everyone but forcing policy.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
