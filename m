Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTARGa0>; Sat, 18 Jan 2003 01:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTARGa0>; Sat, 18 Jan 2003 01:30:26 -0500
Received: from bitmover.com ([192.132.92.2]:52896 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262789AbTARGaZ>;
	Sat, 18 Jan 2003 01:30:25 -0500
Date: Fri, 17 Jan 2003 22:39:21 -0800
From: Larry McVoy <lm@bitmover.com>
To: Kevin Puetz <puetzk@iastate.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030118063921.GB23597@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kevin Puetz <puetzk@iastate.edu>, linux-kernel@vger.kernel.org
References: <20030118043309.GA18658@bjl1.asuk.net> <20030118052919.GA22751@work.bitmover.com> <b0arl3$59p$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0arl3$59p$1@main.gmane.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent Jamie mail asking him why he things 3(d) is a problem for him,
we'll see what he says.  If he's working on things that compete with BK 
then the answer is no, if he's not, then there is no problem.

We want to help the kernel team, that should be obvious.  I draw the line
where helping the kernel team hurts BitMover, as would any of you in my
position.  Fortunately, it's pretty rare that anyone talented enough to
work on the kernel also wants to work on source management.

We could change the license to have the standard legalese which says you
can't reverse engineer, etc.  If the community at large would prefer that,
we could discuss it.  I suspect that when you realize the implications of 
that legalese, the BKL will seem a lot nicer by comparison.   Would you
rather have something like:

 You may not yourself and may not permit or enable anyone to:  (i)  modify  or
 translate  the Software; (ii) reverse engineer, decompile, or disassemble the
 Software or otherwise reduce the Software to a form understandable by humans,
 except  to  the extent this restriction is expressly prohibited by applicable
 law notwithstanding this limitation; (iii) rent, lease, loan, resell or  cre-
 ate  derivative  works  based  on  the Software; (iv) merge the Software with
 another product; (v) separate the Software into  its  component  parts;  (vi)
 copy the Software, except (A) as expressly provided herein and (B) as reason-
 ably necessary for back up and recovery purposes; or (vii) remove or  obscure
 any proprietary rights notices, labels, copyrights, trademarks, servicemarks,
 confidentiality notices and/or restricted rights notices on or in  the  Soft-
 ware.

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
