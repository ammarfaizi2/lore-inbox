Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbUJZGfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUJZGfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUJZGfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:35:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33173 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262083AbUJZGfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:35:46 -0400
Date: Tue, 26 Oct 2004 08:36:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sivanich@sgi.com
Subject: Re: [PATCH] scheduler: remove redundant #ifdef [trivial]
Message-ID: <20041026063651.GA12795@elte.hu>
References: <20041025233839.GA1524@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025233839.GA1524@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Removes a redundant #ifdef CONFIG_SMP that is nested within an enclosing
> #ifdef CONFIG_SMP.
> 
> Signed-off-by: <paulmck@us.ibm.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
