Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVGPNyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVGPNyd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVGPNv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:51:58 -0400
Received: from cpu2485.adsl.bellglobal.com ([207.236.16.208]:58091 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261619AbVGPNvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:51:05 -0400
Date: Fri, 15 Jul 2005 10:45:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Message-ID: <20050715084505.GD1772@elf.ucw.cz>
References: <200507140912.22532.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507140912.22532.mgross@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Why can't I expect SWSusp work better and more reliable from release to 
> release?  

Patches welcome. Or employ someone to do swsusp development for you.

> Some possible things that could help:
> 
> *Addopt a no-regressions-allowed policy and everthing stops until any 
> identified regressions (in performance, functionally or stability) is fixed 
> or the changes are all rolled back.  This works really well if in addition 
> organized pre-flight testing is done before calling a new version number.  
> You simply cannot rely on ad-hock regression testing and reporting.  Its got 
> too much latency.

This would also mean "no development at all".

> * assign validation folks that the developer need to appease before changes 
> are allowed to be accepted into the tree. 

So... get me someone to test swsusp in each -rc and -mm
release... that would help. If you can't provide the manpower, why are
you whining?

									Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
