Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286461AbRLTXEU>; Thu, 20 Dec 2001 18:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286458AbRLTXEK>; Thu, 20 Dec 2001 18:04:10 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:1787 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S286457AbRLTXDy>; Thu, 20 Dec 2001 18:03:54 -0500
Date: Thu, 20 Dec 2001 23:03:52 GMT
From: ncw@axis.demon.co.uk
Message-Id: <200112202303.fBKN3qY25517@irishsea.home.craig-wood.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.hel p.
In-Reply-To: <WHITEGtPrPrvCWO6hm8000002fb@white.pocketinet.com>
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A20@ottonexc1.ottawa.loran.com> <WHITEGtPrPrvCWO6hm8000002fb@white.pocketinet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nknight@pocketinet.com wrote:
>  Someone without a lot of experience: I have a 1MB connection. (this 
>  user has a 1 Megabit connection)
>  
>  Someone with experience: I have a 1mb/Mb connection. (This person has a 
>  1 megabit connection has used a "standard" abbreviation.)

Actually a 1 Mb/s connection is 1024000 bits/second (ie not 1000000 or
1048576 bits/second).

This came about because a basic voice channel is 64kb/s = 64000
bits/second.  These are aggregated up into 32 channels at a time which
is known as an E1 in Europe.  An E1 is known as a 2 "meg" connection
though it is 2048000 bits/s.  Perhaps the correct appellation is 2
kkib/s?

Poor confused telecoms engineers ;-)

My personal view is that the kiB MiB GiB etc are very ugly but we
should grin and bear it to banish this decimal binary confusion
forever.  Either that or put a note somewhere saying that all k, M and
G are 2^10, 2^20 and 2^30 and forget about it for a generation...

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
