Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRBVWCt>; Thu, 22 Feb 2001 17:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130609AbRBVWCf>; Thu, 22 Feb 2001 17:02:35 -0500
Received: from mail.zmailer.org ([194.252.70.162]:43782 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130392AbRBVWCR>;
	Thu, 22 Feb 2001 17:02:17 -0500
Date: Fri, 23 Feb 2001 00:02:10 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.2 & IPv6
Message-ID: <20010223000210.W15688@mea-ext.zmailer.org>
In-Reply-To: <007101c09ce4$39dc7680$b323ce88@eeng.dcu.ie> <200102222148.f1MLmJr02802@lt.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102222148.f1MLmJr02802@lt.wsisiz.edu.pl>; from lukasz@lt.wsisiz.edu.pl on Thu, Feb 22, 2001 at 10:48:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 10:48:19PM +0100, Lukasz Trabinski demoed 2.4.2:

Complementing the 2.4.2 demo, here is same from 2.2.* also at 6BONE:

$ ping6 3ffe:8010:19::2:2
PING 3ffe:8010:19::2:2(3ffe:8010:19::2:2) from 3ffe:2610:2:fe00:290:27ff:fe85:1530 : 56 data bytes
64 bytes from 3ffe:8010:19::2:2: icmp_seq=0 hops=55 time=454.559 msec
64 bytes from 3ffe:8010:19::2:2: icmp_seq=1 hops=55 time=446.905 msec

--- 3ffe:8010:19::2:2 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max/mdev = 446.905/452.399/456.158/3.537 ms
$ uname -r
2.2.16pre4ft

 
> -- 
> *[ Lukasz Trabinski ]*
> SysAdmin @wsisiz.edu.pl

/Matti Aarnio <matti.aarnio@zmailer.org>
