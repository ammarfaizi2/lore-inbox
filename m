Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSFXWrx>; Mon, 24 Jun 2002 18:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSFXWrw>; Mon, 24 Jun 2002 18:47:52 -0400
Received: from orb45.arach.net.au ([203.34.16.45]:62727 "EHLO
	dugite.summer.ami.com.au") by vger.kernel.org with ESMTP
	id <S315388AbSFXWrv>; Mon, 24 Jun 2002 18:47:51 -0400
Message-Id: <200206242247.g5OMlGg32217@skink.Os2.Ami.Com.Au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: driverfs is not for everything! (was: [PATCH] /proc/scsi/map ) 
In-Reply-To: Message from "Grover, Andrew" <andrew.grover@intel.com> 
   of "Mon, 24 Jun 2002 10:35:53 MST." <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jun 2002 06:47:16 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> It's a matter of where to draw the line. Obviously when we're talking
> physical devices, my tcpip connection to www.yahoo.com is not one. My PS/2

I'm far from expert here, but isn't the network card important here?


> 
> If a device can be accessed by multiple machines concurrently, it should not
> be in driverfs.
> 

Back in the 1970s I used a computer where disk drives, tape drives and RAM 
chould be physically connected to and used by more than one computer at once.

It was an IBM S/370 model 168 MP; you might argue the toss on the RAM, but the 
disk drives were beyond argument.


On which devices should MVS have ignored power cycling?
-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my disposition.

==============================
If you don't like being told you're wrong,
	be right!



