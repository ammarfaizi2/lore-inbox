Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267652AbUG3IPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbUG3IPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 04:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUG3IPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 04:15:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16604 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267652AbUG3IPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 04:15:34 -0400
Date: Fri, 30 Jul 2004 10:13:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: [patch] voluntary-preempt-2.6.8-rc2-mm1-M5
Message-ID: <20040730081326.GA6384@elte.hu>
References: <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729222657.GA10449@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Upon popular request i've merged the latest voluntary-preempt patch to
the latest -mm kernel:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-mm1-M5

	Ingo
