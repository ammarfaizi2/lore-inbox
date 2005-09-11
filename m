Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVIKSxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVIKSxG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVIKSxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:53:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965039AbVIKSxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:53:05 -0400
Date: Sun, 11 Sep 2005 11:52:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: sungem driver patch testing..
In-Reply-To: <20050911.112408.19208990.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0509111151520.3242@g5.osdl.org>
References: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
 <20050911120332.GA7627@infradead.org> <Pine.LNX.4.58.0509110940220.4912@g5.osdl.org>
 <20050911.112408.19208990.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, David S. Miller wrote:
> 
> The Apple firmware actually is the same kind of FORTH firmware the
> SUN cards use too.  Apple bought the FORTH firmware technology from
> Sun so they could use it in their machines.

I think what Christoph was thinking of is when you insert a _regular_ PCI 
card, ie no apple firmware stuff. Now, what OF will do about such a thing, 
I don't know, but I assume it's possible.

		Linus
