Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbULKDCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbULKDCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 22:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbULKDCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 22:02:12 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:62593 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261922AbULKDCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 22:02:02 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1102731973.3228.8.camel@localhost.localdomain>
References: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu>
	 <1102602829.25841.393.camel@localhost.localdomain>
	 <1102619992.3882.9.camel@localhost.localdomain>
	 <20041209221021.GF14194@elte.hu>
	 <1102659089.3236.11.camel@localhost.localdomain>
	 <20041210111105.GB6855@elte.hu>
	 <1102731973.3228.8.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Fri, 10 Dec 2004 22:01:56 -0500
Message-Id: <1102734116.3238.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 21:26 -0500, Steven Rostedt wrote:

> Hi Ingo,  I found the problem! and I now know why John Cooper didn't
                                                    ^^^^^^^^^^^
                                            Sorry, I meant K.R.Foley, 
                                          Since he's the one with the
                                          same ethernet card as me.

> have this problem too.  I have CONFIG_PCI_MSI defined. I don't know why,
> I must have seen the option a while ago and said to myself "That looks
> cool, lets try it". Since I started with the config file of the vanilla
> kernel with your rt patches, it was still on. 

