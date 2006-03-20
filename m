Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWCTJsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWCTJsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 04:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWCTJsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 04:48:17 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:11398 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750956AbWCTJsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 04:48:16 -0500
Date: Mon, 20 Mar 2006 10:46:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: John Reiser <jreiser@BitWagon.com>
Subject: [patch] exec-shield-nx-2.6.16
Message-ID: <20060320094610.GA11020@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've released the exec-shield patch for v2.6.16:

   http://redhat.com/~mingo/exec-shield/exec-shield-nx-2.6.16.patch

this release includes John Reiser's "map the vDSO intelligently" patch, 
which increases the efficiency of prelinking.

	Ingo
