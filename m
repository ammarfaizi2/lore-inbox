Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269428AbRHaWPf>; Fri, 31 Aug 2001 18:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269481AbRHaWP1>; Fri, 31 Aug 2001 18:15:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:270 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269428AbRHaWPM>; Fri, 31 Aug 2001 18:15:12 -0400
Subject: Re: [PATCH] usb fix
To: Andries.Brouwer@cwi.nl
Date: Fri, 31 Aug 2001 23:19:01 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        mdharm-usb@one-eyed-alien.net, torvalds@transmeta.com
In-Reply-To: <200108312203.WAA15637@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Aug 31, 2001 10:03:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cwcv-000477-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but not with 2.4.9, I noticed that my name was added and some
> constant changed. Changing it back revived my CF reader.

Yes you added the entry, someone changed the constant as it didnt work
for them, now you change it back.

I suspect both constants should be in 8)
