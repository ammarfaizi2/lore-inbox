Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269282AbUJKVsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269282AbUJKVsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUJKVsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:48:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47331 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269282AbUJKVsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:48:12 -0400
Subject: Re: [patch] CONFIG_PREEMPT_REALTIME, 'Fully Preemptible Kernel',
	VP-2.6.9-rc4-mm1-T4
From: Lee Revell <rlrevell@joe-job.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       mark_h_johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <32863.192.168.1.5.1097529721.squirrel@192.168.1.5>
References: <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>
	 <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu>
	 <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu>
	 <20041011142953.GA32607@elte.hu>
	 <32863.192.168.1.5.1097529721.squirrel@192.168.1.5>
Content-Type: text/plain
Message-Id: <1097530674.1453.39.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 17:37:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 17:22, Rui Nuno Capela wrote:
> > Ingo Molnar
> >
> > i've released the -T4 VP patch:
> >
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T4
> >
> 
> Very rough indeed. First and only attempt on my SMP/HT box stumbled very
> early at make time (CONFIG_PREEMPT_REALTIME=y):

Ingo, any reason you bump the major version number to U?

Maybe it's my problem, I just posted yesterday on LAU that number
changes are usually bugfix releases, and letter changes represent big,
possibly untested changes.  So we had a few users try T4 and were
surprised it didn't work ;-)

Lee

