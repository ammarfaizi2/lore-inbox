Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278800AbRKXQIj>; Sat, 24 Nov 2001 11:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278808AbRKXQI3>; Sat, 24 Nov 2001 11:08:29 -0500
Received: from mail110.mail.bellsouth.net ([205.152.58.50]:18011 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278800AbRKXQIU>; Sat, 24 Nov 2001 11:08:20 -0500
Message-ID: <3BFFC5ED.71E975E7@mandrakesoft.com>
Date: Sat, 24 Nov 2001 11:08:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: ISP Client <summer@os2.ami.com.au>, linux-kernel@vger.kernel.org
Subject: Re: EXTRAVERSION =-greased-turkey
In-Reply-To: <Pine.LNX.4.33.0111240858040.9212-100000@numbat.os2.ami.com.au> <20011124010705.G3141@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 2.4.15 has the potential to corrupt your filesystems slightly on reboot.
> Al provides a safe method to reboot without this corruption, but it will
> still be a good idea to force a fsck on boot, using:
> 
>         shutdown -F -r now

Or,

touch /forcefsck

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

