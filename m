Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSCYPkp>; Mon, 25 Mar 2002 10:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310660AbSCYPkf>; Mon, 25 Mar 2002 10:40:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22280 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311644AbSCYPk1>; Mon, 25 Mar 2002 10:40:27 -0500
Subject: Re: IDE and hot-swap disk caddies
To: summer@os2.ami.com.au (John Summerfield)
Date: Mon, 25 Mar 2002 15:56:07 +0000 (GMT)
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org,
        mlord@pobox.com (Mark Lord)
In-Reply-To: <200203250932.g2P9W0g04463@numbat.Os2.Ami.Com.Au> from "John Summerfield" at Mar 25, 2002 05:32:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pWpL-0000pg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The device is hot-swap capable and has a switch (others have a key) 
> that locks the drive in and powers it up; in the other position the 
> drive is powered down and can be removed.

Linux doesn't support IDE hot swap at the drive level. Its basically
waiting people to want it enough to either fund it or go write the code
