Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132880AbRASBsZ>; Thu, 18 Jan 2001 20:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132911AbRASBsO>; Thu, 18 Jan 2001 20:48:14 -0500
Received: from [63.109.146.2] ([63.109.146.2]:51953 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S132880AbRASBsC>;
	Thu, 18 Jan 2001 20:48:02 -0500
Message-ID: <4461B4112BDB2A4FB5635DE1995874320223D5@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: linux-kernel@vger.kernel.org
Subject: Is there a Crystal 4299 sound driver?
Date: Thu, 18 Jan 2001 17:47:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know of a driver for the Crystal 4299 sound chip?

I grepped through /drivers/sound in both 2.2.18 and 2.4.0. 

The only hints were that "ac97_codec.c" has two codec id's listed for it.
>From old changelogs I see that Mulder Tjeerd was involved in adding those...
perhaps he is writing a driver?  

Any hints would be appreciated.

Torrey Hoffman
torrey.hoffman@myrio.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
