Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSHGKvI>; Wed, 7 Aug 2002 06:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSHGKvI>; Wed, 7 Aug 2002 06:51:08 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:15283 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317110AbSHGKvH>; Wed, 7 Aug 2002 06:51:07 -0400
Date: Wed, 7 Aug 2002 11:53:04 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Leif Sawyer <lsawyer@gci.com>, Ben Greear <greearb@candelatech.com>,
       abraham@2d3d.co.za, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ethtool documentation
Message-ID: <20020807115304.B14073@kushida.apsleyroad.org>
References: <BF9651D8732ED311A61D00105A9CA31509E4BD84@berkeley.gci.com> <Pine.LNX.3.95.1020806214553.26399A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020806214553.26399A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Aug 06, 2002 at 09:51:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> This is not about 'freedom'. This is about modifying some hardware
> to make it pretend that it's something that it is not. It's completely
> unlike IP addresses or anything like that. It is supposed to uniquely
> identify a piece of hardware. It's like the "frequency of a radio station"
> where the IP address is like the "call sign".

That right, and it's very useful.  How else would I have the freedom to
connect different computers onto the cable modem at home when our router
dies? (The cable service only allows a single registered MAC address)

And how else would I have the freedom to replace the old ISA NIC at
work, and continue to run the MAC-locked licensed compiler?

If nobody restricted freedoms by keying to the MAC address, I'd never
want to change it.  But they do.  And if the NICs didn't allow for
reprogramming it, I'd guess that there would be a Linux flag to run the
cards in promiscuous mode to simulate a fake MAC address in software..

-- Jamie
