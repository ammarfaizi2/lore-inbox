Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWIJNPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWIJNPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWIJNPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:15:07 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:13275 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932130AbWIJNPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:15:06 -0400
Date: Sun, 10 Sep 2006 15:07:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-ID: <20060910130722.GA27159@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <4503DC64.9070007@free.fr> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <450406D2.6010305@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450406D2.6010305@free.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Laurent Riffard <laurent.riffard@free.fr> wrote:

> Ingo, I attached my .config to my first post. mmm... It did not reach 
> LKML, so here is it again.

unfortunately i cannot reproduce it - could you send the screenshots 
(privately)? Which version of gcc are you using?

	Ingo
