Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWBRMzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWBRMzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWBRMzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39323 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751232AbWBRMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:07 -0500
Date: Fri, 17 Feb 2006 00:28:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3-mm1
Message-ID: <20060216232807.GQ3490@openzaurus.ucw.cz>
References: <20060214014157.59af972f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214014157.59af972f.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Again, please cast an eye across this patch series for things which should
>   go into 2.6.16.
...

> -suspend-to-ram-allow-video-options-to-be-set-at-runtime-fix.patch
> 
>  Folded into suspend-to-ram-allow-video-options-to-be-set-at-runtime.patch

I'd quite like this one to go in. It is not critical and it is not bugfix,
but it is fairly simple...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

