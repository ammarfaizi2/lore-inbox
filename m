Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281908AbRKZQ2i>; Mon, 26 Nov 2001 11:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281909AbRKZQ23>; Mon, 26 Nov 2001 11:28:29 -0500
Received: from ev6.be.wanadoo.com ([195.74.212.41]:39940 "EHLO
	ev6.be.wanadoo.com") by vger.kernel.org with ESMTP
	id <S281908AbRKZQ2Z>; Mon, 26 Nov 2001 11:28:25 -0500
Message-ID: <3C026E8F.C228A9AE@altern.org>
Date: Mon, 26 Nov 2001 17:32:15 +0100
From: SpaceWalker <spacewalker@altern.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linuxlist@visto.com
CC: linux-kernel@vger.kernel.org
Subject: Re: no inetd.conf file
In-Reply-To: <3BE1CB8E0013F650@iso2.vistocorporation.com> (added by
		    administrator@vistocorporation.com)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is an off-topic subject, because it is not kernel-based problem
look into /etc/xinetd/ and maybe you'll find yourself a response to your
problem.
rohit prasad wrote:
> 
> Hi,
> 
>  I have installed 2.4.7 version of the kernel in my machine.
> I am facing a problem with telnet where all connections are refused.
> 
>  When I grep for telnetd there is no telnetd  running.
> If I try to start it the error reported is ,
> 
> "telnetd:getpeername:socket operation on non-socket"
> 
> I checked for the inetd.conf file it is not present in the /etc directory.
> 
>  I want to know does this xinetd.conf file helps or,
> what else could I do to start telnetd.
> 
> I have done a "Everything" (All packages) installation of RH7.2 but no inetd.conf
> 
> Thanks ,
> Rohit
> 
> 
> 
> ___________________________________________________________________________
> Visit http://www.visto.com.
> Find out  how companies are linking mobile users to the
> enterprise with Visto.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
SpaceWalker

spacewalker@altern.org
ICQ 36157579
