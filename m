Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUJFAMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUJFAMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUJFAMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:12:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:40107 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266481AbUJFAMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:12:43 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20041005194458.GA15629@elte.hu>
References: <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>
	 <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu>
	 <20041005134707.GA32033@elte.hu>
	 <32799.192.168.1.5.1096994246.squirrel@192.168.1.5>
	 <20041005184226.GA10318@elte.hu>
	 <32787.192.168.1.5.1097005084.squirrel@192.168.1.5>
	 <20041005194458.GA15629@elte.hu>
Content-Type: text/plain
Message-Id: <1097021562.1359.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 20:12:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 15:44, Ingo Molnar wrote:
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
> 
> > OTOH, I've tested T1 with CONFIG_SCHED_SMT and/or CONFIG_SMP not set,
> > and got similar crashes too. So this seems to be some nasty bug
> > introduced by -mm{1,2}, not by VP on SMP/SMT.
> > 
> > Yes, I do have some critical USB devices around here. One is that
> > wacom tablet (mouse) and the other is a tascam us-224 audio/midi
> > control surface that a love very much :)
> > 
> > Don't know if this makes me feeling better, doh.
> 
> i believe Andrew said that these USB problems should be fixed in the 
> next -mm iteration.
> 

FWIW, this one does not work for me either, I get a USB-related Oops on
boot.

Lee 

