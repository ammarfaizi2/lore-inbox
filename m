Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317333AbSFGTQx>; Fri, 7 Jun 2002 15:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSFGTQw>; Fri, 7 Jun 2002 15:16:52 -0400
Received: from horus.webmotion.com ([209.87.243.246]:44421 "EHLO
	horus.webmotion.ca") by vger.kernel.org with ESMTP
	id <S317333AbSFGTQt>; Fri, 7 Jun 2002 15:16:49 -0400
Message-ID: <3D010688.30101@bonin.ca>
Date: Fri, 07 Jun 2002 15:16:24 -0400
From: Andre Bonin <kernel@bonin.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, fr-ca
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Chris Fuller <cfuller@broadjump.com>, linux-kernel@vger.kernel.org
Subject: Re: Tyan S2464 (K7 SMP) + EMU10K1 hardlocks
In-Reply-To: <97B71B827DFB2B448A73EC00E5DA0EE605E04A@logos.inhouse.broadjump.com> 	<3D00F107.8070402@bonin.ca> <1023475933.25522.49.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 2002-06-07 at 18:44, Andre Bonin wrote:
> 
>>Creative Labs warns that it's sblive series of cards aren't compatible 
>>with SMP systems.  Though i've had the S2460 motherboard and the only 
>>trouble i have had was that EAX didn't work properly.  A friend of mine 
>>has an sblive with a dual celeron and he also has had this problem of 
>>deadlocks with the SBLive.  The audigy however is fully compatible.
> 
> 
> On Linux at least I've never had a problem with the SB Live since the
> SMP bugs in earlier 2.4 trees got fixed (and they were kernel bugs). I
> can well believe the SB emulation magic doesn't work with old games in
> SMP mode but we don't drive it in any emulation mode nor need to
> 

It may be that there software, livewear, is buggy on SMP systems. Again 
it's cryptic, they do not state if it is the board or only the driver.

Like i said, i've been running windowsXP/linux2.5.20 on a dual athlon 
motherboard (Tyan S2460 before it busted, now i have an Asus A7M-266) 
and both worked fine.  My friend's dual celeron didn't take the sblive 
too nicley.

It could also be a power supply issue.  Maby the sound card is the drop 
that spills the glass.

I found

http://www.americas.creative.com/support/kbase/article.asp?ID=473&Centric=108



> 
> 



