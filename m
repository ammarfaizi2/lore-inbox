Return-Path: <linux-kernel-owner+w=401wt.eu-S932749AbWLZXkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbWLZXkW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 18:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbWLZXkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 18:40:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37658 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749AbWLZXkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 18:40:22 -0500
Date: Wed, 27 Dec 2006 00:37:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Alexey Dobriyan <adobriyan@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org,
       devel@openvz.org
Subject: Re: [PATCH] Consolidate default sched_clock()
Message-ID: <20061226233730.GA6003@elte.hu>
References: <20061225124316.GB11109@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061225124316.GB11109@localhost.sw.ru>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -0.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-0.4 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0287]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@openvz.org> wrote:

> Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>

looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
