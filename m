Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290344AbSAXVkL>; Thu, 24 Jan 2002 16:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290343AbSAXVkB>; Thu, 24 Jan 2002 16:40:01 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:52650 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290337AbSAXVjz>; Thu, 24 Jan 2002 16:39:55 -0500
Date: Thu, 24 Jan 2002 22:39:47 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: pogosyan@phys.ualberta.ca
cc: whitney@math.berkeley.edu,
        Rasmus =?iso-8859-1?Q?B=F8g?= Hansen <moffe@amagerkollegiet.dk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
  chipset)
In-Reply-To: <3C505702.7B665083@phys.ualberta.ca>
Message-ID: <Pine.LNX.4.40.0201242238550.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 pogosyan@phys.ualberta.ca wrote:

>
> I have ASUS A7V266-E (AS99127F chip) and lm_sensors 2.6.2
> shows 43 C for CPU without any additional lines in /etc/sensors.conf
>
> Which sounds reasonable.   However this temperature is rarely ever change !
> I typically have 43.1,   sometimes 42.8   and that's it.   Even after 2-3 min
>
> compiles.    So something is wrong

yes ... you  have no working power-saving ... so the cpu runs at full
power all the time ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

