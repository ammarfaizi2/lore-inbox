Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVGGR4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVGGR4h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGGRy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:54:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15771 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261522AbVGGRw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:52:59 -0400
Date: Thu, 7 Jul 2005 19:52:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PREEMPT_RT and mptfusion
Message-ID: <20050707175231.GA29046@elte.hu>
References: <1120633558.6225.64.camel@ibiza.btsn.frna.bull.fr> <20050706120848.GB16843@elte.hu> <1120653209.6225.96.camel@ibiza.btsn.frna.bull.fr> <1120659178.6225.99.camel@ibiza.btsn.frna.bull.fr> <20050706143157.GA22156@elte.hu> <1120719326.6225.102.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120719326.6225.102.camel@ibiza.btsn.frna.bull.fr>
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


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Same problem with this patch and CONFIG_PCI_MSI=y
> This is not the solution.

ok, -51-12 should have a better fix - does that kernel work for you with 
PCI_MSI=y?

	Ingo
