Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271645AbRIBRGK>; Sun, 2 Sep 2001 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271646AbRIBRF7>; Sun, 2 Sep 2001 13:05:59 -0400
Received: from mail11.svr.pol.co.uk ([195.92.193.23]:36192 "EHLO
	mail11.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S271645AbRIBRFr>; Sun, 2 Sep 2001 13:05:47 -0400
Date: Thu, 30 Aug 2001 22:00:09 +0100
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Tester <tester@videotron.ca>, linux-kernel@vger.kernel.org
Subject: Re: Bizzare crashes on IBM Thinkpad A22e
Message-ID: <20010830220009.A3660@wyvern>
Reply-To: adrian.bridgett@iname.com
Mail-Followup-To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
	Tester <tester@videotron.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108301139310.8245-100000@TesterTop.PolyDom> <20010830195041.N1146@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010830195041.N1146@arthur.ubicom.tudelft.nl>
User-Agent: Mutt/1.3.20i
From: Adrian Bridgett <adrian.bridgett@iname.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 19:50:41 +0200 (+0000), Erik Mouw wrote:
[snip]
> Could you try to boot with "mem=one MB less than the machine actually
> has" and see if that fixes the problem? So "mem=127M" for a 128MB
> machine. If that fixes the problem, I think there is a bug in the e820
> BIOS memory map and you should ask IBM to fix their BIOS.

You can actually use the number that showd on boot (mem=125435K or
whatever...)

OTOH since I switched to 2.4 I havn't needed that (TP770X).

Adrian

Email: adrian.bridgett@iname.com
Windows NT - Unix in beta-testing. GPG/PGP keys available on public key servers
Debian GNU/Linux  -*-  By professionals for professionals  -*-  www.debian.org
