Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281865AbRKWCoC>; Thu, 22 Nov 2001 21:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281866AbRKWCnw>; Thu, 22 Nov 2001 21:43:52 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:18185 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S281865AbRKWCnl>;
	Thu, 22 Nov 2001 21:43:41 -0500
Subject: Re: Thinkpad t21 hard lockup when left overnight
From: Shaya Potter <spotter@cs.columbia.edu>
To: Jeff Chua <jchua@fedex.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0111231023490.15987-100000@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.42.0111231023490.15987-100000@boston.corp.fedex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 22 Nov 2001 21:43:21 -0500
Message-Id: <1006483403.10497.2.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-22 at 21:27, Jeff Chua wrote:
> 
> On 22 Nov 2001, Shaya Potter wrote:
> 
> > When I've left my thinkpad on overnight (without apm --suspend'ing it)
> > when I wake up in the morning, it's locked up hard.  For some reason it
> > seems to run for a few hours w/o any interaction on the machine itself,
> 
> You need to run apmd. Without it, it'll freeze your system. I had a 240X
> and a 240Z. Both will freeze after a while if I don't run apmd.
> 
> The Thinkpad works better under Linux than Windows98!

I am.

root       254  0.0  0.1  1292  508 ?        S    08:58   0:00
/usr/sbin/apmd -P /etc/apm/apmd_proxy

