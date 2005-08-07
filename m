Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752729AbVHGUwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbVHGUwN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbVHGUwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:52:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31907 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752729AbVHGUwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:52:12 -0400
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508071349580.3258@g5.osdl.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
	 <1123447130.12766.35.camel@mindpipe>
	 <Pine.LNX.4.58.0508071349580.3258@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 16:52:10 -0400
Message-Id: <1123447931.12766.37.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 13:50 -0700, Linus Torvalds wrote:
> 
> On Sun, 7 Aug 2005, Lee Revell wrote:
> > 
> > It looks like CONFIG_4KSTACKS has gone away (IOW 8K stacks are no longer
> > an option).  But now I get this ominous warning when I compile
> > ndiswrapper:
> 
> It's still there, and it (still) depends on DEBUG_KERNEL. Nothing should 
> have changed afaik..

OK, thanks, sorry for the noise.  I remember there was talk recently of
4K stacks for everyone and was afraid it had already happened.

Lee

