Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSHFUnP>; Tue, 6 Aug 2002 16:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSHFUnP>; Tue, 6 Aug 2002 16:43:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315628AbSHFUnO>;
	Tue, 6 Aug 2002 16:43:14 -0400
Date: Tue, 6 Aug 2002 13:42:20 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <root@chaos.analogic.com>, Chris Friesen <cfriesen@nortelnetworks.com>,
       <linux-kernel@vger.kernel.org>, <abraham@2d3d.co.za>
Subject: Re: ethtool documentation
In-Reply-To: <1028671126.18478.190.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0208061340030.10089-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Aug 2002, Alan Cox wrote:

| On Tue, 2002-08-06 at 21:03, Richard B. Johnson wrote:
| > Sure you can. And it was assumed that the MAC address provided by
| > the manufacturer would always be used by the software for the MAC
| > address on the wire. However, 'software engineers' have decided
|
| Umm no
|
| DECnet used dynamically assigned MAC addresses from the beginning and
| Digital (now Compaq (now HP)) were one of the creators of the original
| DIX ethernet standard
|
| Thats why several boards allow you to have a pair of receiving MAC
| addresses.

Do you mean several unicast MAC addresses, as opposed to
broadcast + several multicast + (one) unicast MAC address?
If so, I'm not familiar with that scenario.

-- 
~Randy

