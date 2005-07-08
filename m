Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVGHLsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVGHLsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVGHLsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:48:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1203 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262583AbVGHLsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:48:41 -0400
Date: Fri, 8 Jul 2005 13:48:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050708114838.GA12272@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507071237.42470.s0348365@sms.ed.ac.uk> <20050707114223.GA29825@elte.hu> <200507081047.07643.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507081047.07643.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Well, just to let others who have this problem know, it's clear that 
> Ingo's rt-preempt patches increase stack pressure on systems (like 
> mine) where stack is borderline under 4K by default.

btw., which gcc version are you using?

	Ingo
