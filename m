Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290084AbSAWVFi>; Wed, 23 Jan 2002 16:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290102AbSAWVFW>; Wed, 23 Jan 2002 16:05:22 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:46047 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290081AbSAWVEO> convert rfc822-to-8bit; Wed, 23 Jan 2002 16:04:14 -0500
Date: Wed, 23 Jan 2002 22:04:10 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Ed Sweetman <ed.sweetman@wmich.edu>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020123205457.D5FB9141C@shrek.lisa.de>
Message-ID: <Pine.LNX.4.40.0201232201190.2478-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Hans-Peter Jansen wrote:

> It is working somehow, and the 2 degrees are significant in my case, because
> the 45°C is pretty stable in unloaded state with apm enabled. Tmax is around
> 48°C when compiling kde, transcoding divx or the like.

uhh ... this does not sound like any working power saving ... (imho)

> I know, and I think Daniel should have noted that one have to disable APM to
> get ACPI power savings work. Would have saved me one reboot..

sorry ... i didn't know this :) ... i only played around with acpi ... i
haven't tested it with apm and or apm/acp at the same time ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

