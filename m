Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUBRHmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUBRHmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:42:37 -0500
Received: from david.siemens.de ([192.35.17.14]:17037 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id S263760AbUBRHme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:42:34 -0500
From: Christoph Stueckjuergen <christoph.stueckjuergen@siemens.com>
Organization: Siemens AG
To: Nick Piggin <piggin@cyberone.com.au>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.6.1 Scheduler Latency Measurements (Preemption diabled/enabled)
Date: Wed, 18 Feb 2004 08:42:22 +0100
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200402031724.17994.christoph.stueckjuergen@siemens.com> <4032DEEA.1060007@tmr.com> <4032E4F0.8080307@cyberone.com.au>
In-Reply-To: <4032E4F0.8080307@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402180842.22967.christoph.stueckjuergen@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 18. Februar 2004 05:07 schrieb Nick Piggin:
> > Have you considered repeating your test on 2.6.3-rc3-mm1 or similar
> > with all of the most recent thinking on scheduling?
>
> They shouldn't make a difference here. Christoph is using
> realtime scheduling, so he's really measuring preempt off
> time + context switch overhead. The actual scheduler can't
> really help here.

I set up these measurements for a course on Embedded Linux and I must repeat 
them with a current kernel anyway when the course actually starts. If 
anything changes, I will let you know!

Christoph

