Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbRGQBnc>; Mon, 16 Jul 2001 21:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbRGQBnV>; Mon, 16 Jul 2001 21:43:21 -0400
Received: from u-16-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.16]:52982
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S267418AbRGQBnC>; Mon, 16 Jul 2001 21:43:02 -0400
Date: Mon, 16 Jul 2001 18:14:27 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "David S. Miller" <davem@redhat.com>
Cc: George Bonser <george@gator.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux default IP ttl
Message-ID: <20010716181426.A1993@bacchus.dhis.org>
In-Reply-To: <CHEKKPICCNOGICGMDODJIEEIDKAA.george@gator.com> <15185.27251.356109.500135@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15185.27251.356109.500135@pizda.ninka.net>; from davem@redhat.com on Sun, Jul 15, 2001 at 03:03:31AM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 03:03:31AM -0700, David S. Miller wrote:

> George Bonser writes:
>  > This has reduced considerably the number of ICMP messages where a packet has
>  > expired
>  > in transit from my server farms. Looks like there are a lot of clients out
>  > there running
>  > (apparently) modern Microsoft OS versions with networks having a lot of hops
>  > (more than 64).
> 
> Why are there 64 friggin hops between machine in your server farm?
> That is what I want to know.  It makes no sense, even over today's
> internet, to have more than 64 hops between two sites.

While I haven't meassure I'd almost be willing to bet my right arm that
you'll find something like that in the AMPR.org packet radio network
which has at least one /8 network so is a considerable part of the
internet's IP space.

  Ralf
