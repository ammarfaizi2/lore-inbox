Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVBWWSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVBWWSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVBWWRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:17:36 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21399 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261620AbVBWWNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:13:51 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0502232048330.14747@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
	 <1109187381.3174.5.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0502232048330.14747@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 17:13:44 -0500
Message-Id: <1109196824.4009.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 20:53 +0000, Hugh Dickins wrote:
> On Wed, 23 Feb 2005, Hugh Dickins wrote:
> > Please replace by new patch below, which I'm now running through lmbench.
> 
> That second patch seems fine, and I see no lmbench regression from it.

Should go into 2.6.11, right?

Lee

