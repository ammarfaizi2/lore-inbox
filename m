Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUJOC0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUJOC0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUJOC0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:26:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16588 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268148AbUJOC0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:26:16 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
From: Lee Revell <rlrevell@joe-job.com>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: Roland Dreier <roland@topspin.com>, karim@opersys.com,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Zanussi <trz@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <16751.12005.419748.661651@kix.watson.ibm.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <416F0071.3040304@opersys.com> <20041014234603.GA22964@elte.hu>
	 <416F14B4.8070002@opersys.com> <52u0swddpk.fsf@topspin.com>
	 <16751.12005.419748.661651@kix.watson.ibm.com>
Content-Type: text/plain
Message-Id: <1097806897.2682.80.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Oct 2004 22:21:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 22:00, Robert Wisniewski wrote:
> Theoretically a problem, in practice not, i.e., good enough for soft/normal
> real-time, not hard real-time; probably wouldn't want my heart monitor on
> it, but then I wouldn't be using Linux for that either :-)

Also, the issue here is how we do debug logging.  You would presumably
not use this at all in production.

Lee 

