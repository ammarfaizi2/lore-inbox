Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSAXJrh>; Thu, 24 Jan 2002 04:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSAXJr2>; Thu, 24 Jan 2002 04:47:28 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:63227 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S286336AbSAXJrU>; Thu, 24 Jan 2002 04:47:20 -0500
Date: Thu, 24 Jan 2002 10:47:16 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Hans-Peter Jansen <hpj@urpla.net>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <1011817776.22707.4.camel@psuedomode>
Message-ID: <Pine.LNX.4.40.0201241046130.6560-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2002, Ed Sweetman wrote:

> 1-2 degrees is within the sensor's deviation.   Either you dont have it
> working correctly or it doesn't work at all in your case.
>
> You also need acpi idle calls, not just apm.   now this is just my guess
> but apm idle calls might either mess things up or be disabled if acpi
> idle calls are used and disconnecting the cpu... either way  you can't
> have this patch work and apm work at the same time.

or the vlc makes enough load on the mashine that there is no realy power
saving ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

