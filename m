Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSHHQGW>; Thu, 8 Aug 2002 12:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSHHQGW>; Thu, 8 Aug 2002 12:06:22 -0400
Received: from webmail25.rediffmail.com ([203.199.83.147]:51690 "HELO
	webmail25.rediffmail.com") by vger.kernel.org with SMTP
	id <S317623AbSHHQGV>; Thu, 8 Aug 2002 12:06:21 -0400
Date: 8 Aug 2002 16:09:59 -0000
Message-ID: <20020808160959.17250.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem in RealTek Ethernet driver
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,
I am facing a problem with the REALTEK Ethernet driver. I have a
RTL8139C realtek chip in my board.

When I transmit the packet out, the packet is coming out as all
0's. I dumped the whole packet in rtl1839_start_xmit (). The
packet is a proper ARP packet. When i captured the packet using
sniffer, the packet came out with all 0's.

Can any body throw some light on this?

with best regards,
Nanda

