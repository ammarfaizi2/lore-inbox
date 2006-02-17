Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWBQUC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWBQUC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWBQUC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:02:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48530 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751582AbWBQUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:02:56 -0500
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
From: Arjan van de Ven <arjan@infradead.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060217195515.GA12501@linuxtv.org>
References: <20060215151711.GA31569@elte.hu>
	 <20060216145823.GA25759@linuxtv.org> <20060216172007.GB29151@elte.hu>
	 <20060217195515.GA12501@linuxtv.org>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 21:02:50 +0100
Message-Id: <1140206570.2980.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, this leaves the question: Is there a slower, but 100% robust
> alternative on Linux for applications which need it?


sysv semaphores probably count


