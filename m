Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268295AbRHJNw1>; Fri, 10 Aug 2001 09:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268287AbRHJNwT>; Fri, 10 Aug 2001 09:52:19 -0400
Received: from cc885639-a.flushing1.mi.home.com ([24.182.96.34]:42253 "HELO
	caesar.lynix.com") by vger.kernel.org with SMTP id <S268149AbRHJNwP>;
	Fri, 10 Aug 2001 09:52:15 -0400
Date: Fri, 10 Aug 2001 09:53:13 +0000
From: Subba Rao <subba9@home.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Half Duplex and Zero Copy IP
Message-ID: <20010810095313.A6219@home.com>
Reply-To: Subba Rao <subba9@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have 2 3Com NICs on my system. They are 3c905C Tornado PCI cards.
The drivers are compiled into the kernel (Slackware 8.0 with kernel 2.4.7).

One of the interfaces will be used as a sniffer interface (without IP address)
and a very high traffic pipes. I do not wish to loose any packets coming to this
interface. Is it better if I initialize the interface in HALF DUPLEX mode? If yes,
how do I set the card to HALF DUPLEX mode? How can I find out the HW (NIC) settings
on the system?

Another question about 3Com NICs, do they perform zero-copy IP? I read that
the performance improves a lot WITHOUT zero-copy IP.

Thanks for any info.
-- 

Subba Rao
subba9@home.com
http://members.home.net/subba9/

GPG public key ID 27FC9217
Key fingerprint = 2B4C 498E 1860 5A2B 6570  5852 7527 882A 27FC 9217
