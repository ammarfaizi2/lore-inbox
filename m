Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBHT6n>; Thu, 8 Feb 2001 14:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131037AbRBHT6X>; Thu, 8 Feb 2001 14:58:23 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55049 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129098AbRBHT6U>;
	Thu, 8 Feb 2001 14:58:20 -0500
Message-ID: <3A82F9BF.5A680E37@mandrakesoft.com>
Date: Thu, 08 Feb 2001 14:55:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Braun <braun@itwm.fhg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: No sound on GA-7ZX (2.4.1-ac6, via audio)
In-Reply-To: <3A82F427.916F8F0C@itwm.fhg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Braun wrote:
> I can not get sound working on a computer with a Gigabyte
> GA-7ZX mainboard (KT133 chipset). Is this a known problem?
> I have attached some config info. Mail me for further details.

> $ cat /proc/driver/via/0/*
> Vendor name      : SigmaTel STAC????
> Vendor id        : 8384 7600

1) Have you turned the master volume and PCM volume -way- up?

2) Does 2.4.1-ac5 work for you?  (ie. did 2.4.1-ac6 break something?)

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
