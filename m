Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVIDIXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVIDIXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVIDIXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:23:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:37552 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750816AbVIDIXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:23:07 -0400
Subject: Re: RFC: i386: kill !4KSTACKS
From: Lee Revell <rlrevell@joe-job.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
In-Reply-To: <431AA3E2.8020909@stesmi.com>
References: <20050902003915.GI3657@stusta.de>
	 <1125805704.14032.71.camel@mindpipe>  <431AA3E2.8020909@stesmi.com>
Content-Type: text/plain
Date: Sun, 04 Sep 2005 04:23:04 -0400
Message-Id: <1125822185.14032.75.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-04 at 09:36 +0200, Stefan Smietanowski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Lee Revell wrote:
> > On Fri, 2005-09-02 at 02:39 +0200, Adrian Bunk wrote:
> > 
> >>4Kb kernel stacks are the future on i386, and it seems the problems it
> >>initially caused are now sorted out.
> >>
> >>Does anyone knows about any currently unsolved problems?
> > 
> > 
> > ndiswrapper
> 
> While I agree ndiswrapper has a use ... I don't think we should
> base kernel development upon messing with something that is designed
> to run a windows driver in linux ...

Good point, but I don't think we should needlessly render people's
hardware inoperable either.

Lee

