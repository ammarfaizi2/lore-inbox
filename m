Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSHFUhV>; Tue, 6 Aug 2002 16:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSHFUhV>; Tue, 6 Aug 2002 16:37:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23540 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315758AbSHFUhT>; Tue, 6 Aug 2002 16:37:19 -0400
Subject: Re: ethtool documentation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       abraham@2d3d.co.za
In-Reply-To: <Pine.LNX.3.95.1020806155358.25303A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020806155358.25303A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 22:58:46 +0100
Message-Id: <1028671126.18478.190.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 21:03, Richard B. Johnson wrote:
> Sure you can. And it was assumed that the MAC address provided by
> the manufacturer would always be used by the software for the MAC
> address on the wire. However, 'software engineers' have decided

Umm no

DECnet used dynamically assigned MAC addresses from the beginning and
Digital (now Compaq (now HP)) were one of the creators of the original
DIX ethernet standard

Thats why several boards allow you to have a pair of receiving MAC
addresses.

