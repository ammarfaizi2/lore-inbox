Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289085AbSANWFe>; Mon, 14 Jan 2002 17:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289086AbSANWFY>; Mon, 14 Jan 2002 17:05:24 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:51385 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S289085AbSANWFJ>; Mon, 14 Jan 2002 17:05:09 -0500
Message-ID: <3C4355AE.5676F0F3@kolumbus.fi>
Date: Tue, 15 Jan 2002 00:03:26 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <200201140033.BAA04292@webserver.ithnet.com>
		<E16PvKx-00005L-00@the-village.bc.nu> <20020114104532.59950d86.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> 
> Just a short question: the last (add-on) patch to mini-ll I saw on the 

It was for full-ll, not for mini-ll.

> patches: drivers/net/3c59x.c
> drivers/net/8139too.c
> drivers/net/eepro100.c
> 
> Unfortunately me have neither of those. This would mean I cannot benefit 
> from _these_ patches, but instead would need _others_ (like tulip or
> name-one-of-the-rest-of-the-drivers) to see _some_ effect you tell me I
> _should_ see (I currently see _none_). How do you argue then against the
> statement: we need patches for /drivers/net/*.c ?? I do not expect 
> 3c59x.c to be particularly bad in comparison to tulip/*.c or lets say 
> via-rhine.c, do you?

I also checked the tulip driver (which is the one I use at home) and didn't
find need for "fixing" there. I will definitely take a closer look at that
driver in future.

WLAN drivers seem to need some hacking, but I'm not very interested in that
area. I think WLAN is one big security hole that noone should be using...


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

