Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVC2JIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVC2JIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVC2JIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:08:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11436 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262223AbVC2JHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:07:15 -0500
Date: Tue, 29 Mar 2005 11:07:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] logdev debugging memory device for tough to debug areas
Message-ID: <20050329090707.GD7074@elte.hu>
References: <1109032784.32648.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109032784.32648.24.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I've created a tracing tool several years ago for my master's thesis 
> against the 2.2 kernel and onto the 2.4 kernel. I'm currently using 
> this in the 2.6 kernel to debug some customizations against Ingo's RT 
> kernel.

neat. It seems there's some overlap with relayfs, which is in -mm 
currently:

 http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/broken-out/relayfs.patch

	Ingo
