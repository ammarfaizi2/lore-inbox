Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTAWMRs>; Thu, 23 Jan 2003 07:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTAWMRs>; Thu, 23 Jan 2003 07:17:48 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:16611 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265169AbTAWMRr>;
	Thu, 23 Jan 2003 07:17:47 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15919.57224.848343.778122@harpo.it.uu.se>
Date: Thu, 23 Jan 2003 13:26:48 +0100
To: jason andrade <jason@rtfmconsult.com>
Cc: Jacek Radajewski <jacek@usq.edu.au>, Seth Mos <knuffie@xs4all.nl>,
       "" <linux-poweredge@dell.com>, "" <linux-kernel@vger.kernel.org>
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
In-Reply-To: <Pine.GSO.4.50.0301230948210.772-100000@luna.rtfmconsult.com>
References: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
	<Pine.GSO.4.50.0301230948210.772-100000@luna.rtfmconsult.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jason andrade writes:
 > On Thu, 23 Jan 2003, Jacek Radajewski wrote:
 > 
 > > is the network card really the problem ?  I don't want to be replacing all my network cards if the problem is elsewhere .... if you can understand the oops message please, please, please let me know where the problem is ...
 > >
 > 
 > Jacek,
 > 
 > To date there are about 20 replies that say they have had some degree of problems
 > with broadcom chipset based network interfaces and about 2 that say it works without
 > any problems for them.  All of the people having problems say it ranges from interface
 > issues, to causing the entire machine to panic or worse, to hang until power cycled
 > or reset.

For the record, _our_ Dell PE 2650 has been running RH7.3 and RH8.0 since August,
and it's been solid as a rock. Neither the Broadcom NIC nor the tg3 driver has
ever given us any problems.
