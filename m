Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129808AbRBORur>; Thu, 15 Feb 2001 12:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129782AbRBORuh>; Thu, 15 Feb 2001 12:50:37 -0500
Received: from datafoundation.com ([209.150.125.194]:63250 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S129560AbRBORuZ>; Thu, 15 Feb 2001 12:50:25 -0500
Date: Thu, 15 Feb 2001 12:49:29 -0500 (EST)
From: John Jasen <jjasen@datafoundation.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: John Jasen <jjasen1@umbc.edu>,
        Michal Jaegermann <michal@ellpspace.math.ualberta.ca>,
        <linux-kernel@vger.kernel.org>, <axp-list@redhat.com>,
        <denis@datafoundation.com>
Subject: Re: 2.4.x/alpha/ALI chipset/IDE problems summary Re: 2.4.1 not fully
 sane on Alpha - file systems
In-Reply-To: <Pine.LNX.4.10.10102011415070.17898-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0102151247410.4654-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, the situation is improving, I suppose ...

Under kernel 2.4.0 and 2.4.1, a dd of about 10000 4k blocks would cause
the system to go technicolor and lock up.

Now, under 2.4.1-ac13, at about 11000 blocks, it goes technicolor, but
doesn't lock up until somewhere between 13000 and 20000.

*wry shrug*



