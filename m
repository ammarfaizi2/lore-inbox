Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbTCEQBu>; Wed, 5 Mar 2003 11:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTCEQBu>; Wed, 5 Mar 2003 11:01:50 -0500
Received: from [66.70.28.20] ([66.70.28.20]:41737 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267545AbTCEQBs>; Wed, 5 Mar 2003 11:01:48 -0500
Date: Wed, 5 Mar 2003 17:12:44 +0100
From: DervishD <raul@pleyades.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
Message-ID: <20030305161244.GB19439@DervishD>
References: <20021129132126.GA102@DervishD> <3DF08DD0.BA70DA62@gmx.de> <b453er$qo7$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b453er$qo7$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Peter :)

 H. Peter Anvin dixit:
> That, and the 1 MB limitation, is the reason it either needs to get
> nuked or get some massive surgery.  I am currently trying to get Linus
> to accept a patch to put it out of its misery.

    Please, try to convince Marcello and Alan, too. The 2.4 branch
will be a happier branch (well, assuming that the Linux kernel has
feelings, of course) without the raw kernel image booting. Anyway, it
doesn't seem to work for El Torito emulated floppies... I will be the
first who cry for this ancient code, but I think now it doesn't make
sense. Anyone uses floppies yet? Here in Spain a floppy is more
expensive than a 80 min. CD...

    Raúl
