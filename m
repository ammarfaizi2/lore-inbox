Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVCXQrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVCXQrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVCXQrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:47:10 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52186 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262635AbVCXQq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:46:57 -0500
Subject: Re: 2.6.12-rc1-mm2
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050324044114.5aa5b166.akpm@osdl.org>
References: <20050324044114.5aa5b166.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 11:46:52 -0500
Message-Id: <1111682812.23440.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 04:41 -0800, Andrew Morton wrote:
>   -mm kernels now aggregate Linus's tree and 34 subsystem trees.  Usually
>   they are pulled 3-4 hours before the release of the -mm kernel.  
> 

Andrew,

Do you notify the subsystem maintainers ahead of time so that critical
fixes can be pushed to BK?

I am thinking of the recent ALSA example, where the emu10k1 driver was
b0rked in 2.6.12-mm1, but the fix had been in ALSA CVS for a week.

Lee

