Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVHSHDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVHSHDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 03:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVHSHDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 03:03:42 -0400
Received: from ozlabs.org ([203.10.76.45]:62343 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964835AbVHSHDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 03:03:42 -0400
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, riel@redhat.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050817.214845.120320066.davem@davemloft.net>
References: <20050817173818.098462b5.akpm@osdl.org>
	 <20050817.194822.92757361.davem@davemloft.net>
	 <20050817210532.54ace193.akpm@osdl.org>
	 <20050817.214845.120320066.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 17:03:47 +1000
Message-Id: <1124435027.23757.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 21:48 -0700, David S. Miller wrote:
> From: Andrew Morton <akpm@osdl.org>
> Date: Wed, 17 Aug 2005 21:05:32 -0700
> 
> > Perhaps by uprevving the compiler version?
> 
> Can't be, we definitely support gcc-2.95 and that compiler
> definitely has the bug on sparc64.

I believe we just ignored sparc64.  That usually works for solving these
kind of bugs. 8)

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

