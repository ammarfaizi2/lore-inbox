Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269364AbRHCI7O>; Fri, 3 Aug 2001 04:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269363AbRHCI7E>; Fri, 3 Aug 2001 04:59:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7296 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269364AbRHCI6u>;
	Fri, 3 Aug 2001 04:58:50 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15210.26574.374615.6434@pizda.ninka.net>
Date: Fri, 3 Aug 2001 01:58:54 -0700 (PDT)
To: Pekka Savola <pekkas@netcore.fi>
Cc: <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: missing icmp errors for udp packets
In-Reply-To: <Pine.LNX.4.33.0108022225490.5167-100000@netcore.fi>
In-Reply-To: <Pine.LNX.4.33.0107301552230.10196-100000@netcore.fi>
	<Pine.LNX.4.33.0108022225490.5167-100000@netcore.fi>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pekka Savola writes:
 > As this happening is rather rare, would there be resistance for adding
 > this as an intermediate fix, to be replaced later with a bigger overhaul
 > if that is to be decided?
 > 
 > For 99.9% of cases, this works rather well and the 0.1% is the same as
 > before (== acceptable).  Returning ICMP unreachables after being pinged is
 > IMO rather important.

Please people, just make some decision and send me the final
patch :-)

Later,
David S. Miller
davem@redhat.com
