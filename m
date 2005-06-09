Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVFIMOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVFIMOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVFIMOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:14:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8867 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262366AbVFIMOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:14:01 -0400
Date: Thu, 9 Jun 2005 14:13:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050609121326.GB17414@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42A73023.4040707@stud.feec.vutbr.cz> <20050609114510.GA10969@elte.hu> <42A8316E.6000104@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A8316E.6000104@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Ingo Molnar wrote:
> >thanks - i have added it to my tree and have uploaded the -48-03 release 
> >with your patch included.
> 
> This hunk should not be in the patch:

indeed - new patch uploaded.

	Ingo
