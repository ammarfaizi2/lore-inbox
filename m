Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267966AbTBVXSy>; Sat, 22 Feb 2003 18:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267968AbTBVXSy>; Sat, 22 Feb 2003 18:18:54 -0500
Received: from bitmover.com ([192.132.92.2]:47276 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267966AbTBVXSy>;
	Sat, 22 Feb 2003 18:18:54 -0500
Date: Sat, 22 Feb 2003 15:28:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222232859.GC31268@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <2080000.1045947731@[10.10.2.4]> <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca> <20030222221739.GF10411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222221739.GF10411@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 02:17:39PM -0800, William Lee Irwin III wrote:
> On Sat, Feb 22, 2003 at 05:06:27PM -0500, Mark Hahn wrote:
> > ccNUMA worst-case latencies are not much different from decent 
> > cluster (message-passing) latencies.
> 
> Not even close, by several orders of magnitude.

Err, I think you're wrong.  It's been a long time since I looked, but I'm
pretty sure myrinet had single digit microseconds.  Yup, google rocks,
7.6 usecs, user to user.  Last I checked, Sequents worst case was around
there, right?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
