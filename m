Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318855AbSHLWeU>; Mon, 12 Aug 2002 18:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318856AbSHLWeU>; Mon, 12 Aug 2002 18:34:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6922 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S318855AbSHLWeT>;
	Mon, 12 Aug 2002 18:34:19 -0400
Date: Tue, 13 Aug 2002 00:38:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Fredrik Ohrn <ohrn@chl.chalmers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sungem 0.97 driver doesn't work with "Sun GigabitEthernet/P 2.0" card.
Message-ID: <20020812223803.GA13993@alpha.home.local>
References: <Pine.LNX.4.44.0208122129030.17687-100000@feline.chl.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208122129030.17687-100000@feline.chl.chalmers.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 09:39:54PM +0200, Fredrik Ohrn wrote:
 
> OK, I also have an identical card sitting in a Sun Enterprise 450 box.
> In case someone can tell me how to do it in Solaris 8 I can check how 
> the card is configured there.

the most verbose I've found is "prtconf -v". I remember a long time ago,
someone showed me something which strangely looked like lspci with an
hex dump, but I don't remember what, unfortunately.

I hope this helps a bit.
Willy

