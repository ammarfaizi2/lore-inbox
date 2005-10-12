Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbVJLTxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbVJLTxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVJLTxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:53:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53464 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751512AbVJLTxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:53:53 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <5bdc1c8b0510121241q526f5d4cx84c9df2ec744fec9@mail.gmail.com>
References: <20051011111454.GA15504@elte.hu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
	 <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
	 <1129065696.4718.10.camel@mindpipe>
	 <5bdc1c8b0510120937r45bbd26fr6f45b6e3a9895d3f@mail.gmail.com>
	 <1129139304.10599.15.camel@mindpipe>
	 <5bdc1c8b0510121100o11e0e28ft4b532ba43e170774@mail.gmail.com>
	 <1129141547.11297.4.camel@mindpipe> <1129142282.11410.7.camel@mindpipe>
	 <5bdc1c8b0510121211g5a46282fm2e34188875261bb7@mail.gmail.com>
	 <5bdc1c8b0510121241q526f5d4cx84c9df2ec744fec9@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 15:52:15 -0400
Message-Id: <1129146735.11640.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 12:41 -0700, Mark Knecht wrote:
> Any ideas on when someone might look at the IRQ-off problem in rc4-rt1
> that I've reported?

This is almost certainly not related to your xruns.  Presumably it will
be fixed as soon as someone with some amd64 hardware gets a chance to
look at it.  I don't have any.

Lee

