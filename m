Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319330AbSHVMYI>; Thu, 22 Aug 2002 08:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319332AbSHVMYI>; Thu, 22 Aug 2002 08:24:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:14098 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S319330AbSHVMYH>; Thu, 22 Aug 2002 08:24:07 -0400
Date: Thu, 22 Aug 2002 09:27:36 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 and full ipv6 - will it happen?
In-Reply-To: <Pine.LNX.4.44.0208220009110.3234-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44L.0208220926360.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, Thunder from the hill wrote:
> On 21 Aug 2002, Alan Cox wrote:
> > So IPv6 neither helps nor hinders
>
> Well, it's not too easy any more to say "I am the Alan Cox client. Send me
> naked children." If you were ever hit by that or similar, you'd certainly
> think differently, once you've seen that these "tools" for IPv4 are
> mainstream, while the tools for IPv6 are rather rare, and the fake packets
> got discarded anyway. If they're unlikely to be discarded -- I can't
> agree. They just were.

Filtering is a question of proper ingress/egress setup by
the ISPs.  This is fairly common in the ipv4 world, but
not yet common enough.

The ipv6 world hasn't yet started _route filtering_, let
alone ingress/egress filtering ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

