Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWCaQlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWCaQlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCaQlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:41:06 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:12454 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751422AbWCaQlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:41:05 -0500
Subject: Re: snd_hda_intel on 2.6.16
From: Lee Revell <rlrevell@joe-job.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060331162023.M25456@linuxwireless.org>
References: <20060331162023.M25456@linuxwireless.org>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 11:40:58 -0500
Message-Id: <1143823259.24736.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 10:29 -0600, Alejandro Bonilla wrote:
> Hi,
> 
> I read about a problem with snd_hda_intel latelly on 2.6.16. I was not having
> this on 2.6.15-19 but looks like it is "chip-monking"
> 

Too cryptic.  What exactly is the problem?

> I use linux2.6 git and it is still present. Just wanted to let you'll know
> about it.
> 
> Should anyone need any info, please let me know.
> 

Well, for starters, your hardware info ("hda-intel" describes 1000s of
slightly different devices).

Does it work with the latest ALSA CVS or 1.0.11-rc4?

Lee

