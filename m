Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTBXS1n>; Mon, 24 Feb 2003 13:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbTBXS1B>; Mon, 24 Feb 2003 13:27:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267372AbTBXS0s>;
	Mon, 24 Feb 2003 13:26:48 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Andy Pfiffer <andyp@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030222232859.GC31268@work.bitmover.com>
References: <2080000.1045947731@[10.10.2.4]>
	 <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca>
	 <20030222221739.GF10411@holomorphy.com>
	 <20030222232859.GC31268@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046111814.12223.8.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 10:36:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 15:28, Larry McVoy wrote:
> On Sat, Feb 22, 2003 at 02:17:39PM -0800, William Lee Irwin III wrote:
> > On Sat, Feb 22, 2003 at 05:06:27PM -0500, Mark Hahn wrote:
> > > ccNUMA worst-case latencies are not much different from decent 
> > > cluster (message-passing) latencies.
> > 
> > Not even close, by several orders of magnitude.
> 
> Err, I think you're wrong.  It's been a long time since I looked, but I'm
> pretty sure myrinet had single digit microseconds.  Yup, google rocks,
> 7.6 usecs, user to user.  Last I checked, Sequents worst case was around
> there, right?

FYI: The Intel/DOE ASCI Red system (>1 TFLOPS) delivered user-to-user
messaging of < 5us.  With a tail wind, peak point-to-point data rates,
delivered from a user-mode buffer into another user-mode buffer anywhere
else on the system were just shy of 400 megabytes/second (actual rates
could be affected by several factors -- obviously).


Andy


