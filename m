Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311452AbSCNPrP>; Thu, 14 Mar 2002 10:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311635AbSCNPrF>; Thu, 14 Mar 2002 10:47:05 -0500
Received: from bitmover.com ([192.132.92.2]:23474 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S311452AbSCNPqu>;
	Thu, 14 Mar 2002 10:46:50 -0500
Date: Thu, 14 Mar 2002 07:46:49 -0800
From: Larry McVoy <lm@bitmover.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020314074649.H9010@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com> <20020314085456.B13186@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020314085456.B13186@riesen-pc.gr05.synopsys.com>; from Alexander.Riesen@synopsys.com on Thu, Mar 14, 2002 at 08:54:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 08:54:56AM +0100, Alex Riesen wrote:
> Just tried it:
> $ bk clone -rv2.4.18-pre8 linux-2.5 linux-2.4
> remote: ERROR-rev v2.4.18-pre8 doesn't exist

Whoops, sorry, I thought I had checked that.  OK, try

	bk clone -rv2.4.0 linux-2.5 linux-2.4

and then try the pull.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
