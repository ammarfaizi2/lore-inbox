Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWINTNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWINTNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWINTNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:13:17 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12945 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751046AbWINTNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:13:16 -0400
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on
	recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
From: Lee Revell <rlrevell@joe-job.com>
To: Robin Lee Powell <rlpowell@digitalkingdom.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060914190548.GI4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org>
	 <20060914190548.GI4610@chain.digitalkingdom.org>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 15:14:08 -0400
Message-Id: <1158261249.7948.111.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 12:05 -0700, Robin Lee Powell wrote:
> This isn't just me.  All the Debian kernels hang too.  I've tried
> all of the following:
> 
> Linux version 2.6.8-12-amd64-generic (buildd@bester) (gcc version
> 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:12:05
> UTC 2006
> 
> Linux version 2.6.8-12-amd64-k8 (buildd@bester) (gcc version 3.4.4
> 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:39:03 UTC
> 2006
> 
> Linux version 2.6.8-12-amd64-k8-smp (buildd@bester) (gcc version 3.4.4
> 20050314 (prerelease) (Debian 3.4.3-13)) #1 SMP Mon Jul 17 00:17:20
> UTC 2006 

Have you tried a *recent* 2.6 kernel like 2.6.17 or 2.6.18-rc*?

2.6.8 is way too old to debug.

Lee

