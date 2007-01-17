Return-Path: <linux-kernel-owner+w=401wt.eu-S932097AbXAQJDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXAQJDp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbXAQJDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:03:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46686 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097AbXAQJDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:03:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] Fix CONFIG_COMPAT_VDSO
In-Reply-To: Ingo Molnar's message of  Wednesday, 17 January 2007 09:49:47 +0100 <20070117084947.GA19093@elte.hu>
X-Windows: putting new limits on productivity.
Message-Id: <20070117090334.5B6EB1800E8@magilla.sf.frob.com>
Date: Wed, 17 Jan 2007 01:03:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i think your patches #1...#7 are must-haves for v2.6.20, while #8-#11 
> could be delayed to v2.6.21?

Indeed 1-7 are fixes while 8-11 are only cleanups not changing behavior.


Thanks,
Roland
