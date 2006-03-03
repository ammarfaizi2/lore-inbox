Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWCCXkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWCCXkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWCCXkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:40:31 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:41098 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751050AbWCCXka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:40:30 -0500
Subject: Re: Realtime Kernel Slows My Clock
From: Lee Revell <rlrevell@joe-job.com>
To: Chuck Martin <v4b1bze02@sneakemail.com>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <28925-53282@sneakemail.com>
References: <28925-53282@sneakemail.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 18:40:27 -0500
Message-Id: <1141429228.3042.155.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 18:12 -0500, Chuck Martin wrote:
> I've recently been trying to compile a realtime kernel for audio
> work, and am having a problem.  The clock seems to run very slow,
> causing my time to be off.  Commands with a delay are also slowed
> from 10 to 30 times what they should be.  For example, "sleep 1"
> will sometimes take up to thirty seconds. 

Please post your kernel .config.  Is this a dual core AMD?

Lee

