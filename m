Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWDHDv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWDHDv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 23:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWDHDv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 23:51:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965011AbWDHDv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 23:51:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] coredump: optimize ->mm users traversal
In-Reply-To: Oleg Nesterov's message of  Friday, 7 April 2006 02:06:07 +0400 <20060406220607.GA232@oleg>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20060408035153.A24141809D1@magilla.sf.frob.com>
Date: Fri,  7 Apr 2006 20:51:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch looks good to me.

Signed-off-by: Roland McGrath <roland@redhat.com>


Thanks,
Roland
