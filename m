Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVKVSDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVKVSDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVKVSDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:03:35 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:34516 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965069AbVKVSDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:03:32 -0500
Subject: Re: 2.6.14-rt13 does not build
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1132622910.4772.4.camel@mindpipe>
References: <1132599511.29178.69.camel@mindpipe>
	 <1132600755.29178.80.camel@mindpipe>  <1132622910.4772.4.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 13:03:16 -0500
Message-Id: <1132682597.7596.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 20:28 -0500, Lee Revell wrote:
> I'm trying to work around it by
> compiling with high res timers even though I don't have the hardware
> to support them. 

Does not with with high res timers enabled either - it boots halfway
then I just get endless screenfuls of "============================".

Can anyone reproduce the failure to build or boot 2.6.14-rt13 with my
config?

Lee



