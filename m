Return-Path: <linux-kernel-owner+w=401wt.eu-S1161520AbWLPVX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161520AbWLPVX5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 16:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161521AbWLPVX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 16:23:57 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:37176 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161520AbWLPVX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 16:23:57 -0500
Date: Sat, 16 Dec 2006 21:23:46 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org, linux-mm <linux-mm@kvack.org>,
       David Miller <davem@davemloft.net>
Subject: Re: Recent mm changes leading to filesystem corruption?
Message-ID: <20061216212346.GA4426@unjust.cyrius.com>
References: <20061216155044.GA14681@deprecation.cyrius.com> <1166302516.10372.5.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166302516.10372.5.camel@twins>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2006-12-16 21:55]:
> What is not clear from all these reports is what architectures this is
> seen on. I suspect some of them are i686, which together with the
> explicit mention of ARM make it a cross platform issue.

Problems have been seen at least on x86, x86_64 and arm.
-- 
Martin Michlmayr
tbm@cyrius.com
