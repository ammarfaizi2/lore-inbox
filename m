Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbSBJWFw>; Sun, 10 Feb 2002 17:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSBJWFm>; Sun, 10 Feb 2002 17:05:42 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:7119 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S282967AbSBJWFh>; Sun, 10 Feb 2002 17:05:37 -0500
Date: Sun, 10 Feb 2002 23:05:29 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Rasmus =?iso-8859-1?Q?B=F8g?= Hansen <moffe@amagerkollegiet.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: status on northbridge disconnection apm saving?
In-Reply-To: <Pine.LNX.4.33.0202080727400.3223-100000@mf1.private>
Message-ID: <Pine.LNX.4.40.0202102303020.25882-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Wayne Whitney wrote:

> Well, if you have a KT133 (or even KT133A?), I provided the diffs on the
> northbridge register settings, there were only about 6 points of
> difference.  So you could check how your BIOS programs them and then
> explicitly change them with setpci.
>
> Wayne

i'm sorry ... i have no kt133/kt133a chipset ... i have a kt266a chipset
... i will look whether i could fiddle out how to deactivate the pci
master read caching in my board to look whether i get the problems to.
(that is the problem: i have no problems with the patch and can't
reproduce the problems on my board ... so i can't do testing stuff to find
out how to correct the problems)...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

