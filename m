Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSHGKZ3>; Wed, 7 Aug 2002 06:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317770AbSHGKZ3>; Wed, 7 Aug 2002 06:25:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:4089 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317767AbSHGKZ3>; Wed, 7 Aug 2002 06:25:29 -0400
Subject: Re: ethtool documentation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       abraham@2d3d.co.za
In-Reply-To: <Pine.LNX.3.95.1020806215309.26428A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020806215309.26428A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 12:47:43 +0100
Message-Id: <1028720863.18130.262.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 02:57, Richard B. Johnson wrote:
> > DECnet used dynamically assigned MAC addresses from the beginning and
> > Digital (now Compaq (now HP)) were one of the creators of the original
> > DIX ethernet standard
> > 
> > Thats why several boards allow you to have a pair of receiving MAC
> > addresses.
> > 
> 
> That's not the MAC address. That's the multicast hash. They are
> different. The MAC address says who you are. The multicast hash

No thats a unicast address not a multicast hash entry. Go read the
Decnet protocol specifications

