Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVL0B2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVL0B2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVL0B2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:28:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:28114 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932183AbVL0B2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:28:01 -0500
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jules Villard <jvillard@ens-lyon.fr>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <20051227011932.GA9771@blatterie>
References: <20051226194527.GA3036@blatterie>
	 <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
	 <20051227011932.GA9771@blatterie>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 12:27:46 +1100
Message-Id: <1135646867.4780.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> First revert wasn't enough, but the second one made it! Everything is
> working now.

That is not good. See my other mail. I need more infos to understand
what's up.

Ben.


