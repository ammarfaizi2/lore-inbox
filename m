Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUGSKmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUGSKmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 06:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUGSKmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 06:42:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12978 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264957AbUGSKmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 06:42:50 -0400
Date: Mon, 19 Jul 2004 12:36:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] voluntary-preempt 2.6.8-rc2-H4
Message-ID: <20040719103637.GA8924@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random> <20040710075747.GA25052@elte.hu> <2a4f155d040710011041a95210@mail.gmail.com> <20040710082846.GA29275@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710082846.GA29275@elte.hu>
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


i've uploaded the latest (-H4) voluntary-preempt patch to:

  http://redhat.com/~mingo/voluntary-preempt/

Changes from -H3 to -H4:

 - fixes the ext3 bug reported by Zwane Mwaikambo
 - port to 2.6.8-rc2

There are also patches are against 2.6.7-vanilla, 2.6.7-mm7 and
2.6.7-bk20.

	Ingo
