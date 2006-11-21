Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030666AbWKUIGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030666AbWKUIGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWKUIGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:06:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8885 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030666AbWKUIGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:06:06 -0500
Date: Tue, 21 Nov 2006 09:04:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Message-ID: <20061121080442.GA29784@elte.hu>
References: <20061120220230.GA30835@elte.hu> <1164072901.3589.5.camel@monteirov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164072901.3589.5.camel@monteirov>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0960]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:

> On Mon, 2006-11-20 at 23:02 +0100, Ingo Molnar wrote:
> >  - vsyscall & tracing fixes: 'notsc' should not be required on the YUM
> >    rpms anymore. 
> 
> Well I still need it else no boot.

hmm ... still no log capture of that boot failure?

> Sorry for insist, but so difficult after build kernel, copy 
> kernel-devel too, into yum directory ?

sure, i've uploaded it for the latest kernel, and it will probably be 
part of the repository in the future too. Could you check that it works 
for you?

	Ingo
