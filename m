Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290377AbSAXV54>; Thu, 24 Jan 2002 16:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290371AbSAXV4Q>; Thu, 24 Jan 2002 16:56:16 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:33963 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290370AbSAXVzO>; Thu, 24 Jan 2002 16:55:14 -0500
Date: Thu, 24 Jan 2002 22:55:08 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Disconnect <lkml@sigkill.net>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <1011906970.2189.12.camel@oscar>
Message-ID: <Pine.LNX.4.40.0201242252530.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2002, Disconnect wrote:

> 1.3G here.. how much faster does it need to be? (didn't test audio/video
> streams due to the unusability of my keyboard.. I can reboot and try it
> if it would be useful.)
>
> calibrating APIC timer ...
> ..... CPU clock speed is 1302.9962 MHz.
> ..... host bus clock speed is 200.4608 MHz.

ok ... does not look like a speed problen :)
i have 1,4g and it works like a charm ....

hmmm ... maybe acpi problems with the different motherboards ? buggy
implemention of the acpi functions in the bios ? or maybee a fsb problem
(have 133mhz fsb ... does someone with 133mhz fsb have problems to?)

i have no real idea at the moment ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

