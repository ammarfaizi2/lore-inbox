Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131964AbRCVJRR>; Thu, 22 Mar 2001 04:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131965AbRCVJRH>; Thu, 22 Mar 2001 04:17:07 -0500
Received: from samar.sasken.com ([164.164.56.2]:16833 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S131964AbRCVJQy>;
	Thu, 22 Mar 2001 04:16:54 -0500
Date: Thu, 22 Mar 2001 20:15:00 +0530 (IST)
From: Manoj Sontakke <manojs@sasken.com>
To: linux-kernel@vger.kernel.org
Subject: Fib entries
Message-ID: <Pine.LNX.4.21.0103222007440.1689-100000@pcc65.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	I have a question related to forwarding information base(FIB).

Depending upon destination IP address a packet can be 
a) for this machine
b) for a machine to which this machine is directly connected
c) for a machine to which this machine is not directly connected.

Does FIB contain the entries for delivery for all the 3 cases or only for
the third case

Thanks in advance for all the help

Manoj

