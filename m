Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWIXRjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWIXRjD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWIXRjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:39:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:22729 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751285AbWIXRjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:39:01 -0400
Subject: Re: oops in :snd_pcm_oss:resample_expand+0x19c/0x1f0
From: Lee Revell <rlrevell@joe-job.com>
To: Jean-Marc Saffroy <saffroy@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609241825280.4838@erda.mds>
References: <Pine.LNX.4.64.0609241825280.4838@erda.mds>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 13:39:20 -0400
Message-Id: <1159119561.2899.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 19:01 +0200, Jean-Marc Saffroy wrote:
> Yes yes, I know the kernel is tainted "P" (courtesy of the infamous
> Nvidia module), so flame me if you want, but some investigation leads
> me to think it could be an issue in core kernel modules, so read on if
> you still want the gory details. ;-)
> 

Please don't post tainted Oops reports to LKML.  It's not a political
issue, it's a technical one - a tainted kernel CANNOT be debugged.

Reproduce with an untainted kernel and repost.

Lee

