Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWJRIgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWJRIgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWJRIgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:36:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18831 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932107AbWJRIgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:36:54 -0400
Date: Wed, 18 Oct 2006 10:28:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: tb10alj@tglx.de
Subject: Re: [PATCH] remove trailing whitespaces in 2.6.18-rt4
Message-ID: <20061018082842.GA9078@elte.hu>
References: <20060928061847.GB5091@tb10alj3.homag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928061847.GB5091@tb10alj3.homag.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Altenberg <tb10alj@tglx.de> wrote:

> Hi,
> 
> I recognized some trailing whitespaces in lines inserted by the -rt 
> patch:
> 
> - Remove trailing whitespaces from 2.6.18-rt4

thanks, applied.

	Ingo
