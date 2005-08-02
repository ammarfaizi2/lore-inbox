Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVHBFwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVHBFwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVHBFwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:52:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63930 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261382AbVHBFwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:52:10 -0400
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
In-Reply-To: <200508021549.48711.kernel@kolivas.org>
References: <200508021443.55429.kernel@kolivas.org>
	 <200508021549.48711.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 01:52:07 -0400
Message-Id: <1122961928.5490.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 15:49 +1000, Con Kolivas wrote:
> As a crude data point of idle system running a full kde desktop
> environment on 
> powersave with minimal backlight and just chatting on IRC I find it's
> just 
> under 10% battery life difference.

Have you tried the same test but without artsd, or with it configured to
release the sound device after some reasonable time, like 1-2s?  

Lee

