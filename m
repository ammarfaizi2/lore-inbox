Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUHGWX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUHGWX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUHGWX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:23:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59399 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264502AbUHGWX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:23:58 -0400
Date: Sun, 8 Aug 2004 00:09:36 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-rc6
Message-ID: <20040807220936.GA1456@alpha.home.local>
References: <20040807192549.GA26893@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807192549.GA26893@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Sat, Aug 07, 2004 at 04:25:49PM -0300, Marcelo Tosatti wrote:
> Hi, 
> 
> Here goes the last -rc, fixing a couple of typos to the 
> big file offset patch from -rc5.

A few quick checks show that it seems OK right here (athlon SMP, nfs, e1000,
aic7xxx, gcc-2.95.3). No compile problem BTW.

> -final will be out in a couple of hours, now for real.

Ok, so I'mwaiting a couple of hours... :-)

Cheers,
Willy

