Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWAMLwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWAMLwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbWAMLwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:52:47 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:14217 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161202AbWAMLwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:52:46 -0500
Date: Fri, 13 Jan 2006 12:53:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] sched - interactivity updates
Message-ID: <20060113115300.GA25465@elte.hu>
References: <200601132122.39758.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601132122.39758.kernel@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> Changes to the kernel over the last few versions have exposed some 
> weaknesses and quirks in the interactivity estimator. The following 5 
> patches are aimed at addressing these issues. Each changes one unique 
> aspect of the interactivity estimator thus allowing easy comparison if 
> desired.

looks good to me.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo

