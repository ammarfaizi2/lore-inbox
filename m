Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRCBNoj>; Fri, 2 Mar 2001 08:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbRCBNo3>; Fri, 2 Mar 2001 08:44:29 -0500
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:27908 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S129155AbRCBNoZ>; Fri, 2 Mar 2001 08:44:25 -0500
Date: Fri, 2 Mar 2001 14:30:29 +0100 (CET)
From: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>
To: Russell King <rmk@arm.linux.org.uk>
cc: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: negative mod use count
In-Reply-To: <20010302101741.B21799@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.20.0103021429260.1244-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Not necessarily.  Please read the other replies (specifically mine) to
> discover the real answer as to why modules can _legally_ have negative
> use counts.

thanks to all the replies, I think it is a bug in the module since the
use count is -3 :). it is ltmodem driver for lucent win modems...

thnx,
lynx


