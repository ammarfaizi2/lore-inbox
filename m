Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUALTxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 14:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbUALTxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 14:53:06 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:234 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266227AbUALTwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 14:52:45 -0500
Subject: Re: Laptops & CPU frequency
From: john stultz <johnstul@us.ibm.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Robert Love <rml@ximian.com>, jlnance@unity.ncsu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073817226.6189.189.camel@nomade>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>  <1073816858.6189.186.camel@nomade>
	 <1073817226.6189.189.camel@nomade>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1073937159.28098.46.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 11:52:40 -0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-11 at 02:33, Xavier Bestel wrote:
> Le dim 11/01/2004 à 11:27, Xavier Bestel a écrit :
> 
> > > The MHz value in /proc/cpuinfo should be updated as the CPU speed
> > > changes - that is, it is not calculated just at boot, but it is updated
> > > as the speed actually changes.
> > 
> > 2.6.0 doesn't do that on my laptop. Moreover, if I ever boot on battery,
> > when switching to AC power, lots of things fail (mouse is jerky, pcmcia
> > doesn't work ...)
> 
> I forgot one particularly annoying too: time is going twice too fast.

More info please. What type of hardware is this?  Could you send me your
dmesg for booting both with and without AC power? 

thanks
-john

