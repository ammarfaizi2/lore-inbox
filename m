Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271569AbRIPKwJ>; Sun, 16 Sep 2001 06:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271645AbRIPKv7>; Sun, 16 Sep 2001 06:51:59 -0400
Received: from a10d14hel.dial.kolumbus.fi ([212.54.29.10]:17542 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S271569AbRIPKvz>; Sun, 16 Sep 2001 06:51:55 -0400
Message-ID: <3BA48452.653466D4@kolumbus.fi>
Date: Sun, 16 Sep 2001 13:52:02 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Kurshev <nickols_k@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac10
In-Reply-To: <20010908005500.A11127@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alan Cox wrote:
> 
> o       Recognize Radeon VE in radeonfb                 (Nick Kurshev)

This doesn't work for me. Now the video signal goes off (and stays) at boot.
Kernel continues booting, but I can't see anything.

This is probably the same software reset thing as with XFree86 driver.

Best regards,

	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
