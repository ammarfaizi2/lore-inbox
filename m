Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVC2Imq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVC2Imq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVC2IiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:38:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47527 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262202AbVC2IhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:37:25 -0500
Date: Tue, 29 Mar 2005 10:37:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sven Dietrich <sdietrich@mvista.com>
Cc: linux-kernel@vger.kernel.org, "Rt-Dev@Mvista. Com" <rt-dev@mvista.com>
Subject: Re: Realtime preempt
Message-ID: <20050329083713.GA6507@elte.hu>
References: <20050217080304.GA21887@elte.hu> <001901c515ac$ec8032f0$6d00a8c0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901c515ac$ec8032f0$6d00a8c0@mvista.com>
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


* Sven Dietrich <sdietrich@mvista.com> wrote:

> Ingo,
> 
> this patch turns off the preemptable BKL when 
> either PREEMPT_VOLUNTARY or PREEMPT_NONE is selected.

thanks, added it to my tree.

	Ingo
