Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752080AbWCNMrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbWCNMrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWCNMrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:47:55 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:16525 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752080AbWCNMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:47:54 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
Date: Tue, 14 Mar 2006 23:47:19 +1100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1142329861.9710.16.camel@homer> <200603142329.31281.kernel@kolivas.org> <1142340034.11303.20.camel@homer>
In-Reply-To: <1142340034.11303.20.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603142347.19927.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 23:40, Mike Galbraith wrote:
> On Tue, 2006-03-14 at 23:29 +1100, Con Kolivas wrote:
> > On Tuesday 14 March 2006 23:24, Mike Galbraith wrote:
> > > Don't forget, every one of the exploits I test with were posted by
> > > people who were experiencing scheduler problems in real life.  Try to
> > > use your box while running those exploits, and then tell me that you
> > > agree with interbench's assessment.
> >
> > Ok you feel interbench is an irrelevant benchmark for your test case and
> > I'm not going to bother arguing since it doesn't claim to test every
> > single situation.
>
> Yes.  Interbench's opinion is irrelevant to me wrt this problem.

Ok one last try to explain where I'm coming from and then I'll give up ...

Interbench's opinion is not irrelevant to me on this because it may help your 
nfs case but interbench does tell me what happens with X, video, audio etc. 
It's precisely because it quantifies those other scenarios that I care.

Cheers,
Con
