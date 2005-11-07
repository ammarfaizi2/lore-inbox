Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVKGIPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVKGIPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 03:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVKGIPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 03:15:18 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:41950 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751311AbVKGIPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 03:15:17 -0500
Date: Mon, 7 Nov 2005 09:15:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quieten softlockup at boot
Message-ID: <20051107081532.GA30303@elte.hu>
References: <20051107075128.GM12353@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107075128.GM12353@krispykreme>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Blanchard <anton@samba.org> wrote:

> 
> On a large SMP box we get a lot of softlockup thread XX started lines.
> Any objections if we remove them?
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

sure, fine with me - it was just a debugging thing.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
