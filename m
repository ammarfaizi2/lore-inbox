Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270516AbRHNIQ3>; Tue, 14 Aug 2001 04:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270517AbRHNIQT>; Tue, 14 Aug 2001 04:16:19 -0400
Received: from home.paris.trader.com ([195.68.19.162]:26736 "EHLO
	smtp-gw.netclub.com") by vger.kernel.org with ESMTP
	id <S270516AbRHNIQG>; Tue, 14 Aug 2001 04:16:06 -0400
Message-ID: <3B78DE6D.E8DB6B7C@trader.com>
Date: Tue, 14 Aug 2001 10:16:45 +0200
From: joseph.bueno@trader.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-5mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mircea Ciocan <mirceac@interplus.ro>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something that can be done against this ???
In-Reply-To: <E15WK98-0007gd-00@the-village.bc.nu> <3B7822E5.9AE35D4A@interplus.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mircea Ciocan wrote:
> 
>         The attached piece of script kiddie shit is the first one that worked
> flawlessly on my Mandrake box :((( ( kernel 2.4.7ac2, glibc-2.2.3 ),
> instant root access !!!.
>         I was stunned, and it seem that is the beginning of a Linux Code Red
> lookalike worm :(((( using that exploit, probably this is not the most
> apropriate place to send this, but I'm not subscribed to the glibc
> mailing list and I just hope that some glibc hackers are on linux kernel
> list also and they see that and do something before we join the ranks of
> M$.
> 
>                 Dead worried,
> 
>                 Mircea C.
> 
> P.S. Please tell me that I'm just being parnoid and that crap didn't
> work on your systems with a lookalike configuration.
> 
>   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>                Name: smile.sh
>    smile.sh    Type: Bourne Shell Program (application/x-sh)
>            Encoding: quoted-printable

Hi,

The question is not : "is this script dangerous ?",
but "are you ready to blindly execute a shell script
(or any program) that you receive in your  mail ?".

I don't care if this script is dangerous or not because I will never execute it,
or any program that I receive my email before checking its contents and making sure
it is OK.
(And my mail reader will not execute anything automatically, not even Javascript).

If somebody is dumb enough to execute any  program received by email,
don't loose time trying to find some weaknesses in the system; just
send him a shell script with "rm -rf /". It will do enough harm !

Best protection against mail virus is not technical (although it may help),
but user education; and this is true regardless of which operating system
or mail reader is used ! 

Regards
--
Joseph Bueno
NetClub/Trader.com
