Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288566AbSBDGTl>; Mon, 4 Feb 2002 01:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288575AbSBDGTb>; Mon, 4 Feb 2002 01:19:31 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:27909 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S288566AbSBDGTU>; Mon, 4 Feb 2002 01:19:20 -0500
Date: Mon, 4 Feb 2002 01:26:15 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Dan Kegel <dank@kegel.com>, Kev <klmitch@MIT.EDU>,
        Arjen Wolfs <arjen@euro.net>, <coder-com@undernet.org>,
        <feedback@distributopia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <20020204060630Z16287-31368+646@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.44.0202040121160.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Feb 2002, Daniel Phillips wrote:
> In an effort to somehow control the mushrooming number of IO interface
> strategies, why not take a look at the work Ben and Suparna are doing in aio,
> and see if there's an interface mechanism there that can be repurposed?

When AIO no longer sucks on pretty much every platform on the face of the
planet I think people will reconsider.  In the mean time, we've got to
deal with that is there.  That leaves us writing for at least 6 very
similiar, I/O models with varying attributes.

Regards,

Aaron

