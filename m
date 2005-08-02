Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVHBFza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVHBFza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVHBFz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:55:29 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:3214 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261384AbVHBFyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:54:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Date: Tue, 2 Aug 2005 15:56:50 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
References: <200508021443.55429.kernel@kolivas.org> <200508021549.48711.kernel@kolivas.org> <1122961928.5490.10.camel@mindpipe>
In-Reply-To: <1122961928.5490.10.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508021556.50450.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 03:52 pm, Lee Revell wrote:
> On Tue, 2005-08-02 at 15:49 +1000, Con Kolivas wrote:
> > As a crude data point of idle system running a full kde desktop
> > environment on
> > powersave with minimal backlight and just chatting on IRC I find it's
> > just
> > under 10% battery life difference.
>
> Have you tried the same test but without artsd, or with it configured to
> release the sound device after some reasonable time, like 1-2s?

I have it on release after 1 second already.

Cheers,
Con
