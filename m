Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSCKQnn>; Mon, 11 Mar 2002 11:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310202AbSCKQnb>; Mon, 11 Mar 2002 11:43:31 -0500
Received: from bitmover.com ([192.132.92.2]:43436 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310199AbSCKQnW>;
	Mon, 11 Mar 2002 11:43:22 -0500
Date: Mon, 11 Mar 2002 08:43:21 -0800
From: Larry McVoy <lm@bitmover.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: bk://linux.bkbits.net/linux-2.5
Message-ID: <20020311084321.I26447@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <15497.26229.778087.419723@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15497.26229.778087.419723@argo.ozlabs.ibm.com>; from paulus@samba.org on Sat, Mar 09, 2002 at 12:33:41PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2002 at 12:33:41PM +1100, Paul Mackerras wrote:
> Linus,
> 
> Could you push your repository to bk://linux.bkbits.net/linux-2.5
> please?  It is still at 2.5.6-pre2.

I pushed last night, I had forgotten to automate this and have been doing it
by hand.  Linus is letting me deal with this one because he's unhappy with
the locking model in BK and this serves as a reminder that it needs to be
fixed (or at least that's my theory).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
