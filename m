Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSKOJm7>; Fri, 15 Nov 2002 04:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265978AbSKOJm7>; Fri, 15 Nov 2002 04:42:59 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:28175 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S265960AbSKOJm7>; Fri, 15 Nov 2002 04:42:59 -0500
Date: Fri, 15 Nov 2002 09:49:34 +0000
To: Patrick Finnegan <pat@purdueriots.com>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Moving from Linux 2.4.19 LVM to LVM2
Message-ID: <20021115094934.GB2122@reti>
References: <20021114082030.GB1061@reti> <Pine.LNX.4.44.0211142247350.13759-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211142247350.13759-100000@ibm-ps850.purdueriots.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 10:51:48PM -0500, Patrick Finnegan wrote:
> On Thu, 14 Nov 2002, Joe Thornber wrote:
> 
> > On Wed, Nov 13, 2002 at 11:05:37PM -0500, Patrick Finnegan wrote:
> > > Is there an easy and plainless way to do this?  Are the LVM2 tools
> > > backwards-compatible with the old LVM?
> >
> > Yes
> 
> Actually, the answer is aparently "No."  LVM2's tools don't work with a
> 2.4.x kernel.

Had you applied the device-mapper patches for 2.4 ?

- Joe
