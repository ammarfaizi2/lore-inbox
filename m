Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315726AbSENNyZ>; Tue, 14 May 2002 09:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315727AbSENNyY>; Tue, 14 May 2002 09:54:24 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:23054 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S315726AbSENNyY>; Tue, 14 May 2002 09:54:24 -0400
Message-ID: <3CE11705.35E1FFC5@compro.net>
Date: Tue, 14 May 2002 09:54:13 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: conman@kolivas.net
CC: dmarkh@cfl.rr.com, linux-kernel@vger.kernel.org
Subject: Re: Combined low latency & performance patches for 2.4.18
In-Reply-To: <20020429142443.A62481333@pc.kolivas.net> <20020430230105.D5CA01A0AA@pc.kolivas.net> <3CCFA3BD.664EE747@cfl.rr.com> <200205142343.10555.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Mark (and lkml readers)
> 
> On further testing from the feedback I've gotten it seems that this patch
> works fine for gcc 2.95.3 and gcc 3.0.3+
> 
> There is definitely a problem with trying to compile it with gcc2.96

>>As you can see, the low latency is enabled. I didn't see any point in 
>>enabling sysctl so I havent tried that. Perhaps that is it? The other thing 
>>is, I don't believe it works well with SMP which I am not using. 


I'm using 2.95.3 but also SMP. Maybe thats it..

Regards
Mark
