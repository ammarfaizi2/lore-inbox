Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290957AbSAaFzv>; Thu, 31 Jan 2002 00:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSAaFzl>; Thu, 31 Jan 2002 00:55:41 -0500
Received: from bitmover.com ([192.132.92.2]:53678 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290957AbSAaFzY>;
	Thu, 31 Jan 2002 00:55:24 -0500
Date: Wed, 30 Jan 2002 21:55:23 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Rob Landley <landley@trommello.org>, Larry McVoy <lm@bitmover.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130215523.G18381@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Keith Owens <kaos@ocs.com.au>, Rob Landley <landley@trommello.org>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020131051505.MGLL25889.femail29.sdc1.sfba.home.com@there> <9396.1012456003@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9396.1012456003@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Jan 31, 2002 at 04:46:43PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 04:46:43PM +1100, Keith Owens wrote:
> When I release a patch I pick a start
> point (base 2.4.17, patch set 17.1) and an end point (kdb v2.1 2.4.17
> common-2, patchset 17.37) and prcs diff -r 17.1 -r 17.37.  

bk export -tpatch -r17.1,17.37

Does exactly the same thing.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
