Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135759AbRD2MVu>; Sun, 29 Apr 2001 08:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135760AbRD2MVl>; Sun, 29 Apr 2001 08:21:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:47034 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S135759AbRD2MVa>;
	Sun, 29 Apr 2001 08:21:30 -0400
Date: Sun, 29 Apr 2001 14:21:11 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200104291221.OAA37952.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, mdharm-kernel@one-eyed-alien.net
Subject: Re: Dane-Elec PhotoMate Combo
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        mailhot@enst.fr, markus@schlup.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>

    > (ii) this card needs usb/storage/dpcm.c which is compiled when
    > CONFIG_USB_STORAGE_DPCM is set, but this variable is missing
    > from usb/Config.in. Add it.

    This config option is considered so immature that it's not ready for the
    kernel config, even as an EXPERIMENTAL.  Use it at your own risk.

Of course. But the choice is simple. Without it, one has a non-functional
device. With it, one has a device that works beautifully.

