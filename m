Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQKYOAf>; Sat, 25 Nov 2000 09:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKYOA0>; Sat, 25 Nov 2000 09:00:26 -0500
Received: from [192.108.102.201] ([192.108.102.201]:6589 "EHLO myrealbox.com")
        by vger.kernel.org with ESMTP id <S129228AbQKYOAK> convert rfc822-to-8bit;
        Sat, 25 Nov 2000 09:00:10 -0500
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Date: Sat, 25 Nov 2000 14:28:56 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Subject: Re: setting up pppd dial-in on linux 
CC: linux-kernel@vger.kernel.org
Message-ID: <3A1FCCA8.608.1E5DAB@localhost>
In-Reply-To: <20001125003600.A28207@vger.timpanogas.org>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   You are not alone. And the problem gets even worse when you 
have to deal with ISDN devices. In my company´s data room we 
have all Linux servers running 365 days a year (minus upgrade 
time) and in one corner a lonely Windows NT Server 3.0 with 5 
Client Access Licenses working as a RAS server for 2 Diva Server 
BRI cards (4 analog/digital channels) plus one analog modem. 
Time to set it up? Half an hour counting NT installation. Time i lost 
investigating and trying different configurations, dealing with 
contradictory documentation, chat scripts, different ipppd versions, 
and authentication failures? 2 days. At Ieast i cant complain about 
pppd oops, as you do, the pppd in RH6.2 seemed solid. The 
document of reference that seemed more interesting to me at the 
time was http://www.swcp.com/~jgentry/pers.html  , have a look 
please.


Regards,
Pedro

On 25 Nov 2000, at 0:36, Jeff V. Merkey wrote:

> 
> 
> Anyone out there a whiz at setting up a pppd dialin server?  I am 
> trying to put together an RPM for pppd dialin configurations
> that will support default Windows NT and Linux dial in clients
> without requiring the poor user to learn bash scripting, chat 
> scripting, mgetty and inittab configuration, etc.  The steps
> in setting this up are about as easy as going on a U.N. relief
> mission to equatorial Africa, and most customers who are 
> "mere mortals" would give up about an hour into it.
> 
> I am seeing massive problems with pppd dial-in and IP/IPX 
> routing with problems that range from constant Oops, to 
> the bug infested pppd daemon failing valid MD5 chap 
> authentication.  The HOW-TO's and man pages provide 
> wonderful commentary on all the things about pppd 
> that don't work, but it's not too helpful on getting
> it to work reliably.  An NT dial-in server takes about
> 5 minutes to configure on W2K.  Linux takes about 2 days, and 
> won't stay up reliably.  
> 
> Who out there is an expert on Linux pppd that would like
> to help put together some easy configs for standard 
> dial-in scenarios?
> 
> Thanks
> 
> Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
