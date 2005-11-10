Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVKJVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVKJVOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKJVOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:14:45 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:62681 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932077AbVKJVOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:14:45 -0500
Date: Thu, 10 Nov 2005 22:15:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] -rt: Fix ARM IXP4xx compile
Message-ID: <20051110211501.GA6359@elte.hu>
References: <20051110182955.GB27766@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110182955.GB27766@plexity.net>
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


* Deepak Saxena <dsaxena@plexity.net> wrote:

> Need to pick up global IRQ_* definitions.
> 
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

thanks, applied.

	Ingo
