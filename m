Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVIAPFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVIAPFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbVIAPE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:04:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47285 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965182AbVIAPEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:04:55 -0400
Date: Wed, 31 Aug 2005 20:53:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Airlie <airlied@linux.ie>, seife@use.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [git tree] DRM tree for 2.6.14 (fwd)
Message-ID: <20050831185358.GE703@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0508301018330.1102@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508301018330.1102@skynet>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> commit 282a16749ba63256bcdce2766817f46aaac4dc20
> Author: Dave Airlie <airlied@starflyer.(none)>
> Date:   Sun Aug 7 15:43:54 2005 +1000
> 
>     drm: add savage driver
> 
>     Add driver for savage chipsets.
> 
>     From: Felix Kuehling
>     Signed-off-by: Dave Airlie <airlied@linux.ie>


Is it the one that breaks suspend in suse kernels? It tends to load
okay even on machines without savage hw, and then explodes on suspend...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

