Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270310AbUJUHch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270310AbUJUHch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270290AbUJUHc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:32:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22155 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270412AbUJUHbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:31:47 -0400
Date: Thu, 21 Oct 2004 09:33:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, hawkes@sgi.com
Subject: Re: [PATCH] small load balance fix
Message-ID: <20041021073306.GA20510@elte.hu>
References: <200410201223.02924.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410201223.02924.jbarnes@engr.sgi.com>
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


* Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> Small bug fix for domains that don't load balance (like those that only 
> balance on exec for example).
> 
> Signed-off-by: John Hawkes <hawkes@sgi.com>
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
