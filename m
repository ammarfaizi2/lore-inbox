Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271343AbTHRJbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271353AbTHRJbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 05:31:37 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:15574 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S271343AbTHRJbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 05:31:35 -0400
Date: Mon, 18 Aug 2003 11:31:35 +0200
From: Ookhoi <ookhoi@humilis.net>
To: kenton.groombridge@us.army.mil
Cc: Patrick Dreker <patrick@dreker.de>, Jussi Laako <jussi.laako@pp.inet.fi>,
       Alistair J Strachan <alistair@devzero.co.uk>,
       Clock <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
Message-ID: <20030818093135.GA19937@favonius>
Reply-To: ookhoi@humilis.net
References: <7a3f387a6ef2.7a6ef27a3f38@us.army.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3f387a6ef2.7a6ef27a3f38@us.army.mil>
X-Uptime: 09:31:31 up 70 days,  2:00, 39 users,  load average: 1.06, 1.16, 1.11
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kenton.groombridge@us.army.mil wrote (ao):
> It seems that the kernel recognizes all nforce2 chipsets as revision
> 162. That is my bad since I found that seemed to be a common
> denominator. Taking shots in the dark. :^)

My Shuttle SN41G2 also has "NFORCE2: chipset revision 162"

> I will tell you that I know it isn't related to bad hardware. I used a
> program that I borrowed from my office (not a cheap program, and it is
> thorough).

> The reason I say this, is that I have read a few posts where one
> person had lock-ups with one distro and not the other.  Kernels are
> pretty much the same (I think we are all downloading the latest kernel
> source and building our own kernels), but gcc is different.

I've had a few different 2.5 kernels on this one, compiled under always
up to date debian sid (unstable). The system is (and has been) rock
solid, now running 2.5.70 with an uptime of 70 days. Running
http://www.stanford.edu/group/pandegroup/folding

I get this now and then:
favonius kernel: Bank 2: 940040000000017a

favonius kernel: MCE: The hardware reports a non fatal, correctable
incident occurred on CPU 0.

but this goes unnoticed to me. 

This all with an athlon XP 3000+ btw.
