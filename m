Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRIOMVT>; Sat, 15 Sep 2001 08:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272285AbRIOMVJ>; Sat, 15 Sep 2001 08:21:09 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:12074 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S272280AbRIOMVB>; Sat, 15 Sep 2001 08:21:01 -0400
Date: Sat, 15 Sep 2001 12:21:13 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2fs corruption again
Message-ID: <20010915122113.A24561@grobbebol.xs4all.nl>
In-Reply-To: <3BA33818.8030503@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3BA33818.8030503@korseby.net>; from kristian.peters@korseby.net on Sat, Sep 15, 2001 at 01:14:32PM +0200
X-OS: Linux grobbebol 2.4.7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2001 at 01:14:32PM +0200, Kristian Peters wrote:
> I changed my harddrive to IBM 75 GB because someone said that IBM's 40 GB
> harddisks are not very stable.

[....] 

> I might say this is definitely an error with ext2 !

I might say that you could have tried a complete different make drive. who
says that the 75 MB IBM is ok ?

maybe the same design mistake was made or so. just a thought. 

options to see if something weird isn't due to hardware could be to not
use dma, change pio modes, e.g. relax the drive settings. 

not that I say IBM's drive is bad, it's just a thought.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
