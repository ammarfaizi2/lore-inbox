Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbTBCHVD>; Mon, 3 Feb 2003 02:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTBCHVC>; Mon, 3 Feb 2003 02:21:02 -0500
Received: from quechua.inka.de ([193.197.184.2]:14811 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S266041AbTBCHVC>;
	Mon, 3 Feb 2003 02:21:02 -0500
X-Mailbox-Line: From aj@dungeon.inka.de  Mon Feb  3 08:30:29 2003
To: linux-kernel@vger.kernel.org
Subject: Re: Compactflash cards dying?
In-Reply-To: <20030202223009.GA344@elf.ucw.cz>
References: <20030202223009.GA344@elf.ucw.cz>
Date: Mon, 3 Feb 2003 08:30:28 +0100
Message-Id: <20030203073028.B4C2920BD9@dungeon.inka.de>
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had compactflash from Apacer (256MB), and it started corrupting data
> in few months, eventually becoming useless and being given back for
> repair. They gave me another one and it is just starting to corrupt
> data.

last year we had some problems with compactflash. It was only 7bit
clean, not 8bit. However the cards worked fine via usb devices,
but not when used as IDE device.

test if writing 7bit data is reliable :-)

Andreas


