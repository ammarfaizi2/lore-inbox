Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWE3VTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWE3VTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWE3VTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:19:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57069 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932467AbWE3VTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:19:09 -0400
Date: Tue, 30 May 2006 23:19:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [combo patch] lock validator -V2
Message-ID: <20060530211930.GA29358@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <adaac8z70yc.fsf@cisco.com> <20060530202654.GA25720@elte.hu> <ada1wub6y6b.fsf@cisco.com> <20060530204901.GA27645@elte.hu> <adawtc35iws.fsf@cisco.com> <1149022880.3636.116.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149022880.3636.116.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded lock validator -V2, a rollup of all current fixes (against 
-rc5-mm1) to:

 http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm1.patch

(Andrew got all these fixes as individual patches already)

	Ingo
