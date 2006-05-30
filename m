Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWE3K5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWE3K5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWE3K5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:57:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:22489 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932194AbWE3K5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:57:34 -0400
Date: Tue, 30 May 2006 12:57:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530105751.GA3820@elte.hu>
References: <20060529212109.GA2058@elte.hu> <1148964741.7704.10.camel@homer> <20060530063724.GE19870@elte.hu> <1148981134.8532.5.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148981134.8532.5.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2006-05-30 at 08:37 +0200, Ingo Molnar wrote:
> > * Mike Galbraith <efault@gmx.de> wrote:
> > 
> > > Darn.  It said all tests passed, then oopsed.
> > > 
> > > (have .config all gzipped up if you want it)
> > 
> > yeah, please.
> 
> (sent off list)

thanks, i managed to reproduce the warning with your .config - i'm 
debugging the problem now.

	Ingo
