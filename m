Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSGNAmE>; Sat, 13 Jul 2002 20:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSGNAmD>; Sat, 13 Jul 2002 20:42:03 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:33265 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315503AbSGNAmC>; Sat, 13 Jul 2002 20:42:02 -0400
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0207131517510.19986-100000@innerfire.net>
References: <Pine.LNX.4.44.0207131517510.19986-100000@innerfire.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Jul 2002 02:52:35 +0100
Message-Id: <1026611555.13885.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 20:19, Gerhard Mack wrote:
> > Your suspicion and the reality don't match. The RFC's leave the
> > situation unclear and some OS's do either. Newer 2.4 has arpfilter which
> > can be used to control what actually occurs
> 
> Can we at least have matching defaults for ipv4 and ipv6 ??  Having ipv6
> behave the opposite just isn't intuitive.

IPv6 doesn't have ARP it has neighbour discovery. The two are very
different in quite a few ways. 

Alan

