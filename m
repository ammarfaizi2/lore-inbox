Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbTAXGFK>; Fri, 24 Jan 2003 01:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTAXGFK>; Fri, 24 Jan 2003 01:05:10 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:60078
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267559AbTAXGFJ>; Fri, 24 Jan 2003 01:05:09 -0500
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jason andrade <jason@rtfmconsult.com>, Jacek Radajewski <jacek@usq.edu.au>,
       Seth Mos <knuffie@xs4all.nl>, linux-poweredge@dell.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <15919.57224.848343.778122@harpo.it.uu.se>
References: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
	 <Pine.GSO.4.50.0301230948210.772-100000@luna.rtfmconsult.com>
	 <15919.57224.848343.778122@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043388761.12857.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 00:12:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-23 at 06:26, Mikael Pettersson wrote:
> jason andrade writes:
>  > On Thu, 23 Jan 2003, Jacek Radajewski wrote:
>  > 
>  > > is the network card really the problem ?  I don't want to be replacing all my network cards if the problem is elsewhere .... if you can understand the oops message please, please, please let me know where the problem is ...
>  > >
>  > 
>  > Jacek,
>  > 
>  > To date there are about 20 replies that say they have had some degree of problems
>  > with broadcom chipset based network interfaces and about 2 that say it works without
>  > any problems for them.  All of the people having problems say it ranges from interface
>  > issues, to causing the entire machine to panic or worse, to hang until power cycled
>  > or reset.
> 
> For the record, _our_ Dell PE 2650 has been running RH7.3 and RH8.0 since August,
> and it's been solid as a rock. Neither the Broadcom NIC nor the tg3 driver has
> ever given us any problems.

Given the varying degree of answers on this particular thread. I'd say
that the problem is application dependant. Perhaps we can isolate that
in some way?

--
GrandMasterLee
