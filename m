Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268579AbRGYQJA>; Wed, 25 Jul 2001 12:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268580AbRGYQIk>; Wed, 25 Jul 2001 12:08:40 -0400
Received: from www.transvirtual.com ([206.14.214.140]:40965 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S268579AbRGYQI2>; Wed, 25 Jul 2001 12:08:28 -0400
Date: Wed, 25 Jul 2001 09:08:11 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: ps2/ new data for mouse protocol (fwd msg attached)
In-Reply-To: <20010725144531Z266723-720+6195@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10107250905030.8057-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> > However, some mouse secrets from various sources I hacked in here:
> > http://home.t-online.de/home/gunther.mayer/gm_psauxprint-0.01.c -
> 
> Very nice. I am currently looking for some info to solve a problem with 
> thinkpads and logitech cordless mice over ps/2. Basicly the wheel doesnt 
> work. Looking closer they dont respond to the imps/2 or mousemanps/2 
> protocol. Since cordless mice are more common than thinkpads, I think the 
> problem would be solved if it was with the mouse. So I am guessing the IBM 
> defaults to just repeating standard ps/2 protocol, and you have to first 
> trick that before you trick the mouse. Since it works in windows there IS a 
> way...
> 
> Where do I find the public available protocols, and the secrets? :)
> 
> And for the list, who should I notify that I am working on autodetecting IBM 
> thinkpad  ps/2 repeaters in mouse driver?

Actually I'm interested in this work. We have input api drivers for PS/2
devices so it would be easy to add support. Any info would be helpfu to
expand the devices we support.


