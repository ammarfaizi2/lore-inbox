Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUG0J3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUG0J3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUG0J3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:29:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39626 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261300AbUG0J2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:28:33 -0400
Date: Tue, 27 Jul 2004 11:29:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] Recommend 'noapic' when timer via IOAPIC fails
Message-ID: <20040727092958.GA13871@elte.hu>
References: <Pine.LNX.4.58.0407270427500.23985@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407270427500.23985@montezuma.fsmlabs.com>
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


* Zwane Mwaikambo <zwane@fsmlabs.com> wrote:

> We might as well recommend the user boot with the noapic kernel parameter
> instead of filling poor Ingo's mailbox.
> 
> Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

yeah.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
