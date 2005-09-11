Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVIKTD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVIKTD6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVIKTD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:03:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10380
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750726AbVIKTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:03:58 -0400
Date: Sun, 11 Sep 2005 12:03:58 -0700 (PDT)
Message-Id: <20050911.120358.75230990.davem@davemloft.net>
To: willy@w.ods.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: sungem driver patch testing..
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050911070407.GF30279@alpha.home.local>
References: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
	<20050911070407.GF30279@alpha.home.local>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <willy@w.ods.org>
Date: Sun, 11 Sep 2005 09:04:07 +0200

> I've ported it to sunhme (which uses the same PCI ROM mapping code).
> Without the patch, I get NULL MAC addresses for all 4 ports (it's a SUN
> QFE). With the patch, I get the correct addresses (the ones printed on
> the label on the card).
> 
> I attach the patch for sunhme, and Cc: Davem so that he updates his tree.

Thanks, I'll put this into my tree along with Linus's SunGEM
stuff and push upstream after I play with it a little bit
myself :-)

Thanks again.
