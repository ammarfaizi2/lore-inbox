Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUF3PEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUF3PEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266690AbUF3PEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:04:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30181 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266689AbUF3PEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:04:43 -0400
Date: Wed, 30 Jun 2004 17:05:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040630150548.GB28506@elte.hu>
References: <200406301341.i5UDfkKX010518@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406301341.i5UDfkKX010518@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another question: do all JACK threads run at SCHED_FIFO, and do they all 
have the same rt_priority value?

	Ingo
