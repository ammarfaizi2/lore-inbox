Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbUKBMiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUKBMiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUKBMiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:38:19 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62693 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261434AbUKBMhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:37:00 -0500
Date: Tue, 2 Nov 2004 13:37:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove interactive credit
Message-ID: <20041102123746.GB15290@elte.hu>
References: <418707CD.1080903@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418707CD.1080903@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> remove interactive credit

we could try this in -mm, but it obviously needs alot of testing first. 
Do you have any particular workload in mind where the fairness win due
to this revert would/should be significant?

	Ingo

