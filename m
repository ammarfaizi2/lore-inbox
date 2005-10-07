Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbVJGRXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbVJGRXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbVJGRXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:23:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29352 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030522AbVJGRXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:23:32 -0400
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510070944p5a09f7f2m4965f3e0ddda21f7@mail.gmail.com>
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
	 <20051006195242.GA15448@elte.hu>
	 <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com>
	 <5bdc1c8b0510061338r41e0b51ds2efd435a591d953e@mail.gmail.com>
	 <5bdc1c8b0510061907w372cb406x45140b01e4011c4a@mail.gmail.com>
	 <20051007114848.GE857@elte.hu>
	 <5bdc1c8b0510070944p5a09f7f2m4965f3e0ddda21f7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 13:23:24 -0400
Message-Id: <1128705805.17981.42.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 09:44 -0700, Mark Knecht wrote:
> Hi Ingo,
>    OK, I've been running -rt10 for the last couple of hours on a new
> kernel without SMP. No xruns so far at 64/2. I'm doing all the normal
> stuff. emerge sync, building some code outside of portage, playing
> music. Very good so far, but it will likely take 4-6 hours for me to
> be more sure saying it was just SMP latencies.

IIRC you posted some traces that implied the migration thread was
involved.

Lee

