Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290343AbSAXVum>; Thu, 24 Jan 2002 16:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290347AbSAXVue>; Thu, 24 Jan 2002 16:50:34 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:18347 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290343AbSAXVuX>; Thu, 24 Jan 2002 16:50:23 -0500
Date: Thu, 24 Jan 2002 22:50:16 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Pavel Machek <pavel@suse.cz>
cc: Timothy Covell <timothy.covell@ashavan.org>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020124095504.GA297@elf.ucw.cz>
Message-ID: <Pine.LNX.4.40.0201242249320.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Pavel Machek wrote:

> Hi!
>
> You could look for how long CPU was idle, and only if it was mostly
> idle in last 10 seconds enable the bit ;-).
> 									Pavel

i will keep it in my mind ... when nothing other is found which cause the
problems ...

daniel



# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

