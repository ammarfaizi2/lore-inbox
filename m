Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131139AbRBLVhy>; Mon, 12 Feb 2001 16:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131149AbRBLVho>; Mon, 12 Feb 2001 16:37:44 -0500
Received: from innerfire.net ([208.181.73.33]:27402 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S131069AbRBLVhd>;
	Mon, 12 Feb 2001 16:37:33 -0500
Date: Mon, 12 Feb 2001 13:39:07 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Tony Hoyle <tmh@magenta-netlogic.com>
cc: Paul Tweedy <pault@5emedia.net>, linux-kernel@vger.kernel.org
Subject: Re: "Unable to load intepreter" on login - 2.2.14-5.0
In-Reply-To: <3A884456.4080103@magenta-netlogic.com>
Message-ID: <Pine.LNX.4.10.10102121335500.13086-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Tony Hoyle wrote:

> Paul Tweedy wrote:
> 
> > Secondly, to get the thing running I'm assuming I can copy a working login
> > binary from an identical server, so I can get in & change the passwords and
> > sort the security out?
> 
> ...and what if the 'cp' binary has been hacked to stop you doing just 
> that?  What if 'passwd' is silently emailing your root password to the 
> hacker each time you change it?
> 
> Reformat and re-install.  It's the only way (and check your firewall).

Disabling all unneeded services would be a better idea than checking the
firewall.  

<RANT>
I'm still not understanding this running by default most dists
have going, it's stupid for servers and it's down right retarted for
workstations. 
</RANT>

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
