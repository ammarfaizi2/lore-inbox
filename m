Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVLSPmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVLSPmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVLSPmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:42:53 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:55985 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932228AbVLSPmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:42:53 -0500
Subject: Re: 2.6.15-rc5-rt2 build error
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051219162624.6a7f63b5@mango.fruits.de>
References: <20051218210614.75f424eb@mango.fruits.de>
	 <43A5DBF0.6030801@cybsft.com> <20051219154410.4942e826@mango.fruits.de>
	 <20051219162624.6a7f63b5@mango.fruits.de>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 10:46:26 -0500
Message-Id: <1135007186.16112.36.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 16:26 +0100, Florian Schmidt wrote:
> On Mon, 19 Dec 2005 15:44:10 +0100
> Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > Thanks, i found this:
> > 
> > http://lkml.org/lkml/mbox/2005/12/14/246
> > 
> > I'm not on X86_64 though. Plus i do have PREEMPT_RT enabled.
> > 
> > trying this though:
> > 
> > http://lkml.org/lkml/2005/12/13/184
> > 
> > Seems to build fine now.
> 
> But it doesn't run so well. Dmesg contains a BUG and an OOPS:
> 

How about with high res timers disabled?

Lee

