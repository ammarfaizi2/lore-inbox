Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264425AbRFOPhQ>; Fri, 15 Jun 2001 11:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264426AbRFOPg5>; Fri, 15 Jun 2001 11:36:57 -0400
Received: from oscar.broadcom.ie ([192.107.110.20]:4365 "EHLO broadcom.ie")
	by vger.kernel.org with ESMTP id <S264425AbRFOPgf>;
	Fri, 15 Jun 2001 11:36:35 -0400
Message-ID: <F491DB9E5447D51188DF00B0D0AA207503F45C@phoebe.broadcom.ie>
From: Mark Smith <mark.smith@broadcom.ie>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Enabling Netfilters to Mark packets in Red-Hat
Date: Fri, 15 Jun 2001 16:37:53 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to enable Netfilters to mark ip packets, (i.e. using
iptables and iproute2).  My problem is that after upgrading from 2.2.4
kernel to a 2.4 version, I did the following:

make menuconfig - enabling the appropriate options

make dep

make bzImage

make bzlilo


The problem is I cannot get iptables or ipoute2 working.  I can see header
files for iptables, but nothing eslse, and I cannot find any reference to
iproute2 whatsoever.

Can anyone mail me as to what I may be doing wrong?  I am a relative
newcomer to linux.

Cheers.
