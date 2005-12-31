Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVLaH2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVLaH2D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 02:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVLaH2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 02:28:02 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:9740 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751317AbVLaH2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 02:28:00 -0500
Date: Sat, 31 Dec 2005 08:25:28 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20051231072528.GY15993@alpha.home.local>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301955350.22622@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512301955350.22622@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 08:00:34PM -0800, Chris Stromsoe wrote:
> I couldn't get the machine to come up with 2.4.32, 2.4.30, or 2.4.27.  It 
> was hanging and then throwing the SCSI errors below.  The machine did 
> come up with a vanilla 2.6.14.4 and appears to be working fine.  I'm 
> going to leave it up over the weekend and see if it oopses.  If it would 
> help, I can mail out the .config for the 2.4.32 and 2.6.14.4 builds, or 
> provide other information of interest.

Please do post at least the 2.4.32 .config, I'll try to boot it on my
system right here. I find it amazing that it suddenly stopped working
with the same kernels as before.

> -Chris

Willy

