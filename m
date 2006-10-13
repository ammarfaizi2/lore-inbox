Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbWJMVTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWJMVTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWJMVTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:19:54 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7566 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751808AbWJMVTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:19:54 -0400
Subject: Re: 2.6.18-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <200610132318.02512.annabellesgarden@yahoo.de>
References: <20060920141907.GA30765@elte.hu>
	 <1159639564.4067.43.camel@mindpipe> <20060930181804.GA28768@in.ibm.com>
	 <200610132318.02512.annabellesgarden@yahoo.de>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 17:20:54 -0400
Message-Id: <1160774455.4201.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 23:18 +0200, Karsten Wiese wrote:
> Bug just happened here on a tainted UP x86_64 running rt4.
> IIRC this is the second time in 2 weeks or so.
> Machine seams to be fine still after the oops... 

I just hit it again with (untainted) 2.6.18-rt5.

Lee

