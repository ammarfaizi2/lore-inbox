Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266490AbRGXBUB>; Mon, 23 Jul 2001 21:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266562AbRGXBTw>; Mon, 23 Jul 2001 21:19:52 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:39591 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S266490AbRGXBTj>;
	Mon, 23 Jul 2001 21:19:39 -0400
Message-ID: <3B5CCD1C.B969411F@candelatech.com>
Date: Mon, 23 Jul 2001 18:19:24 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, sourav@csa.iisc.ernet.in,
        linux-kernel@vger.kernel.org
Subject: Re: Arp problem
In-Reply-To: <Pine.LNX.4.33.0107240208460.10839-100000@fogarty.jakma.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Paul Jakma wrote:
> 
> On Mon, 23 Jul 2001, Ben Greear wrote:
> 
> > The arp-filter patch is in the kernel since about 2.4.4, so you just need
> > to turn it on...
> 
> on a related note:
> 
> if i have 2 logical subnets on the wire, linux listening on both, is
> there any way to get linux to fully route packets between the 2
> subnets?

You'll have to draw a diagram or do a better job of describing
your network:  I have no idea what you're trying to do!

I think you could use VLANs for what you want to do, but if your
windows boxes can't handle ICMP-redirects, they probably can't
handle VLANs either...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
