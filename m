Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbVJKHsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbVJKHsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 03:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVJKHsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 03:48:30 -0400
Received: from smtpout2.uol.com.br ([200.221.4.193]:46482 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1751403AbVJKHs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 03:48:29 -0400
Date: Tue, 11 Oct 2005 04:48:26 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.14-rc3] BUG: soft lockup detected on CPU#0
Message-ID: <20051011074825.GA7428@ime.usp.br>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20051010204039.30dc1e0e.akpm@osdl.org> <20051011060652.GB19321@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051011060652.GB19321@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Ingo, Andrew and others,

On Oct 11 2005, Ingo Molnar wrote:
> does the patch below help?
> ----
> should solve false-positive soft lockup messages during IDE init.

Unfortunately, I haven't been able to reproduce the problem since I
reported it. It is quite strange to be subject to a transient problem.

I will keep this patch safe and post more information as soon as I can
isolate the problem.


Thank you very much, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
