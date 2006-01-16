Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWAPCHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWAPCHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 21:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWAPCHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 21:07:19 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:9896 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932166AbWAPCHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 21:07:18 -0500
Subject: Re: BTTV broken on recent kernels
From: Lee Revell <rlrevell@joe-job.com>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux kernel Mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <43CAFF82.4030500@telusplanet.net>
References: <43CAFF82.4030500@telusplanet.net>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 21:07:13 -0500
Message-Id: <1137377234.25801.145.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-15 at 19:05 -0700, Bob Gill wrote:
> Hi.  The last several kernel versions have led to broken bttv (up to 4 
> or 5 kernel versions ago, I could watch tv on either mplayer or xawtv), 
> but lately bttv is broken.  My card is an 'bt878 compatible built by ATI 
> (ATI TV Wonder VE).  I'm pretty certain it worked as late as 
> 2.6.14-git7.

You need to do a git bisect (check the list archives) to isolate the
change that broke it.

Lee

