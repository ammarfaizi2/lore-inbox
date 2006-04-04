Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWDDOar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWDDOar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 10:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWDDOar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 10:30:47 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:18742 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932214AbWDDOar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 10:30:47 -0400
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
References: <20060404014504.564bf45a.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B19E9BA0-E04C-46F2-AC22-113E4D6AC8D3@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.17-rc1-mm1
Date: Tue, 4 Apr 2006 09:31:10 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Boilerplate:
>
> - See the `hot-fixes' directory for any important updates to this  
> patchset.
>
> - To fetch an -mm tree using git, use (for example)
>
>   git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/ 
> linux-trees.git v2.6.16-rc2-mm1

It doesn't seem like the git tree got updated correctly.  The 2.6.17- 
rc1-mm1 seems to be just 2.6.17-rc1 (just a quick spot check at  
Makefile and a few patches I expected in like the 64-bit resource  
change)

- kumar
