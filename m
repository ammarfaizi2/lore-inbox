Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270024AbRHGBcw>; Mon, 6 Aug 2001 21:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270023AbRHGBcm>; Mon, 6 Aug 2001 21:32:42 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:19077 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S270022AbRHGBcf>; Mon, 6 Aug 2001 21:32:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Riley Williams <rhw@MemAlpha.CX>
Subject: Re: 3c509: broken(verified)
Date: Tue, 7 Aug 2001 03:00:43 +0200
X-Mailer: KMail [version 1.2.3]
In-Reply-To: <Pine.LNX.4.33.0108070003540.4091-100000@infradead.org>
In-Reply-To: <Pine.LNX.4.33.0108070003540.4091-100000@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010807013236Z270022-28344+2122@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. August 2001 01:11 schrieben Sie:
> Hi Dieter.
>
>  >> You mention the problem is being unable to change the media, I
>  >> was unaware this was even possible with the current 3c509
>  >> driver, and most people do it on 3c509's and other PNP cards of
>  >> this sort (such as NE2000 clones)  by using a DOS boot diskette
>  >> and the DOS utilities provided by the manufacturer.
>  >
>  > That's what I did. I've set it to "auto mode" and it works with
>  > RJ45 cable. But I can't verify if "full duplex" worked right.
>
> What transfer speed do you get doing an FTP transfer across the link?

Don't know. I have to plug a laptop or something on it to test. Perhaps Dad's 
PC (but the later is still connected via switched 100 Mbits ;-)

> 10base is theoretically capable of one meg per second,

1.25 MByte/sec (max)

> and experience
> indicates that a 10baseT link normally shows just under 500k per
> second flat out, presumably due to the half duplex nature of the
> 10baseT protocol. I'd expect 10base2 half duplex to be similar, and
> 10base2 full duplex to be somewhat faster.

I thought it should read 10baseT (with RJ45 cable) can reach 1.25 MByte/sec 
full duplex (switched)?

>
>  > So I changed it under Win to "10baseT" for which the 3Com
>  > utilities say "full duplex" enabled.
>
> One slight problem - 10baseT uses CoAxial cable, not RJ45 - and, as
> far as I'm aware, 10baseT is strictly half duplex whereas 10base2
> (which uses RJ45 twisted pair cable) is capable of either half or full
> duplex.

See above.

Thanks,
	Dieter

PS Before we go full OT I switch to private mode.

