Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSFBCxD>; Sat, 1 Jun 2002 22:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317118AbSFBCxC>; Sat, 1 Jun 2002 22:53:02 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:5012 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S317117AbSFBCxC>; Sat, 1 Jun 2002 22:53:02 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 1 Jun 2002 20:04:33 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Louis Garcia <louisg00@bellsouth.net>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: P4 hyperthreading
In-Reply-To: <1022981972.2456.10.camel@tiger>
Message-ID: <Pine.LNX.4.44.0206011949340.976-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Jun 2002, Louis Garcia wrote:

> I was just thinking about that. Do you now if this has a real speed
> improvement?

intel claims up to 30-40% but i've never tried it. the bottleneck is that
they share fsb and cache but in any case having an extra exec-path might
help more than demage. this is for your sleepless nights :

http://www.intel.com/technology/itj/2002/volume06issue01/art01_hyper/vol6iss1_art01.pdf




- Davide


