Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135900AbREJMGK>; Thu, 10 May 2001 08:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136097AbREJMFn>; Thu, 10 May 2001 08:05:43 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136176AbREJMDc>;
	Thu, 10 May 2001 08:03:32 -0400
Date: Thu, 10 May 2001 01:28:25 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
To: <linux-kernel@vger.kernel.org>
cc: <usagi-users-ctl@linux-ipv6.org>, <linux-ipsec@freeswan.org>
Subject: Question: Status of USAGI/FreeSWAN?
In-Reply-To: <200105100253.f4A2rsK305959@saturn.cs.uml.edu>
Message-ID: <Pine.SOL.4.30.0105100052440.10105-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FreeSWAN has IPSec for IPv4 on Linux.

USAGI is better/more conformant IPv6 (with IPSec for IPv6 in development)
for Linux.

The USAGI goal is to get themselves folded into the official kernel (and
glibc) at some point "in the near future".

What are the plans to get all this (FreeSWAN,USAGI) folded into the
kernel.  Are the "crypto" legal issues resolved enough now to have crypto
in the official kernel?  It would nice to not to have to chase down all
these seperate components and eventually manually patch.

I'm going a bit crazy keeping track of several different kernel patches
(IPSec,IPv6 in particular) while my *BSD friends just laugh at me. :)

Dax

