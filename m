Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRBDPcE>; Sun, 4 Feb 2001 10:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131914AbRBDPbz>; Sun, 4 Feb 2001 10:31:55 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:16597 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S129191AbRBDPbv>; Sun, 4 Feb 2001 10:31:51 -0500
Message-Id: <200102041531.f14FVZr21669@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: "Michael B. Trausch" <fd0man@crosswinds.net>
cc: Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift 
In-Reply-To: Your message of "Sun, 04 Feb 2001 07:56:46 EST."
             <Pine.LNX.4.21.0102040756120.5276-100000@fd0man.accesstoledo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Feb 2001 10:31:35 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Technical explanations aside, some sort of clock drift exists in all 
computers. My experience with Sun hardware, for instance, was that the 
hardware and software clocks rarely agreed.

You should set up your machines to use some sort of time synchronization 
software, such as ntp or rdate. When I didn't have a 24/7 net presence, I had 
my ppp script run ntpdate when the connection was complete.

See http://www.eecis.udel.edu/~ntp/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
