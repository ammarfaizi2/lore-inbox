Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133070AbRDRKZp>; Wed, 18 Apr 2001 06:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133072AbRDRKZZ>; Wed, 18 Apr 2001 06:25:25 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:10758 "EHLO
	gonzales.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S133070AbRDRKZV>; Wed, 18 Apr 2001 06:25:21 -0400
Date: Wed, 18 Apr 2001 03:25:03 -0700
Message-Id: <200104181025.f3IAP3p10344@gonzales.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Steve Hill <steve@navaho.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.21.0104171727300.4446-100000@sorbus.navaho>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.19 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001 17:30:46 +0100 (BST), Steve Hill <steve@navaho.co.uk> wrote:

> Not sure - I've never tried initing more than 3 of the DP83815 cards in a
> single machine.  (I am using Cobalt Qube 3's, which have 2 DP83815's on
> the motherboard, and a single PCI slot which I have installed a DP38315 in
> for testing purposes).

Have you tried the starfire driver in 2.2.19 or 2.4.x-ac? Or, if you want to
use vanilla 2.4.x, you can simply copy drivers/net/starfire.c from the -ac
tree.

Ion
Starfire driver maintainer

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
