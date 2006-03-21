Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWCUEZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWCUEZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 23:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWCUEZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 23:25:17 -0500
Received: from mxsf26.cluster1.charter.net ([209.225.28.226]:34503 "EHLO
	mxsf26.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1030281AbWCUEZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 23:25:16 -0500
Message-ID: <441F8017.4040302@cybsft.com>
Date: Mon, 20 Mar 2006 22:24:55 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
References: <20060320085137.GA29554@elte.hu>
In-Reply-To: <20060320085137.GA29554@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the 2.6.16-rt1 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this is mostly a merge from -rc6 to 2.6.16-final, plus some smaller 
> fixes.
> 
> to build a 2.6.16-rt1 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rt1
> 
> 	Ingo

Ingo,

I haven't had a chance to look into it yet but this combination brings
with it a significant latency regression, at least as measured by the
rtc histogram stuff.

-- 
   kr
