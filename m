Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTDKUCj (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTDKUCj (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:02:39 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:35714 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261707AbTDKUCh (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:02:37 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304112016.h3BKG0TM001931@81-2-122-30.bradfords.org.uk>
Subject: Re: [ANNOUNCE] udev 0.1 release
To: mdresser_l@windsormachine.com (Mike Dresser)
Date: Fri, 11 Apr 2003 21:16:00 +0100 (BST)
Cc: root@chaos.analogic.com (Richard B. Johnson),
       john@grabjohn.com (John Bradford), linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, message-bus-list@redhat.com
In-Reply-To: <Pine.LNX.4.33.0304111553380.14943-100000@router.windsormachine.com> from "Mike Dresser" at Apr 11, 2003 03:59:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Every three-connection connector supplies power to two drives.
> >
> >      |--------D1
> > -----|--------D2    ________D3
> >      |______________|_______D4
> >                     |_______Continue
> Here's the way I thought of it.
> 
>                      |--x -- 3
>        |--------X----|--x -- 3
>        |             |--x -- 3
>        |
>        |             |--x -- 3
> -------|--------X----|--x -- 3
>        |             |--x -- 3
>        |
>        |             |--x -- 3
>        |--------X----|--x -- 3
>                      |--x -- 3
> 
> I now have 1 + 3 + 9 = 13 splitters, giving me 27 connections, out of 1.
> etc, etc. Same numbers I'd have doing it your way, yours would be 13
> levels deep instead.
> 
> I think I just went for the massively parallel method of hooking
> these up and from there got massively lost.

Now, assuming a voltage drop of 0.05V across each cable...

:-)

John.
