Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSHFVGv>; Tue, 6 Aug 2002 17:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSHFVGt>; Tue, 6 Aug 2002 17:06:49 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:40436 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316051AbSHFVFy>; Tue, 6 Aug 2002 17:05:54 -0400
Subject: Re: ethtool documentation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: root@chaos.analogic.com, Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org, abraham@2d3d.co.za
In-Reply-To: <Pine.LNX.4.33L2.0208061340030.10089-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0208061340030.10089-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 23:27:53 +0100
Message-Id: <1028672873.18130.198.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 21:42, Randy.Dunlap wrote:
> Do you mean several unicast MAC addresses, as opposed to
> broadcast + several multicast + (one) unicast MAC address?
> If so, I'm not familiar with that scenario.

Two unicast addresses, one for the sane world one for DECnet. The DEC
tulip supports this as one example

