Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289372AbSBGNxW>; Thu, 7 Feb 2002 08:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289523AbSBGNxL>; Thu, 7 Feb 2002 08:53:11 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:18563 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S289372AbSBGNw7> convert rfc822-to-8bit; Thu, 7 Feb 2002 08:52:59 -0500
Date: Thu, 7 Feb 2002 14:52:56 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: status on northbridge disconnection apm saving?
In-Reply-To: <Pine.LNX.4.44.0202071417050.1378-100000@grignard.amagerkollegiet.dk>
Message-ID: <Pine.LNX.4.40.0202071448070.17566-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Rasmus Bøg Hansen wrote:

> I now fiddled a little with the PCI settings in the BIOS...
>
> When 'PCI master read cahing' is enabled everything works fine (sound
> works, cooling works. When disabled I get sound skips. The above flags
> are exactly the same:
>
> Athlon/Duron CLK_Ctrl Value found : fff0d22f
> Athlon/Duron CLK_Ctrl Value set to : fff0d22f
> Enabling disconnect in VIA northbridge: KT133/KX133 chipset found
>
> As I think i noted earlier, my motherboard is KT133A-based.
>
> My system functions perfectly stable with the 'PCI master read caching'
> enabled - I have no idea whether this is true in general.

hey ... that are great news ... i think i have also something like this in
the bios and i will test it when i am at home... maybe i get the problems
to, when i deactivate this option ... that would give me the possibility
to test this error at my own ...
thanks for testing and for this hint :)

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

