Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSHFUDc>; Tue, 6 Aug 2002 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSHFUDc>; Tue, 6 Aug 2002 16:03:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18445 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315481AbSHFUDb>;
	Tue, 6 Aug 2002 16:03:31 -0400
Date: Tue, 6 Aug 2002 13:04:43 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       <linux-kernel@vger.kernel.org>, <abraham@2d3d.co.za>
Subject: Re: ethtool documentation
In-Reply-To: <Pine.LNX.3.95.1020806155358.25303A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33L2.0208061302200.10089-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Richard B. Johnson wrote:

| On Tue, 6 Aug 2002, Chris Friesen wrote:
|
| > "Richard B. Johnson" wrote:
| >
| > > Because of this, there is no such thing as 'unused eeprom space' in
| > > the Ethernet Controllers. Be careful about putting this weapon in
| > > the hands of the 'public'. All you need is for one Linux Machine
| > > on a LAN to end up with the same IEEE Station Address as another
| > > on that LAN and connectivity to everything on that segment will
| > > stop. You do this once at an important site and Linux will get a
| > > very black eye.
| >
| > Can't we already tell cards (some of them anyway) what MAC address to use when
| > sending packets?  This doesn't overwrite the EEPROM, but it does last for that
| > session...
| >
| > Chris
|
| Sure you can. And it was assumed that the MAC address provided by
| the manufacturer would always be used by the software for the MAC
| address on the wire. However, 'software engineers' have decided

Assumed by whom?  IEEE allows locally administered addresses,
and most NIC mfrs that I know of support/allow them.

| that they don't have to follow the rules, so they provide hooks
| so you can use a MAC address of anything.  They even call it
| "Local Administration...", which decoded means; "Screw the
| committee".

<snippage>

-- 
~Randy

