Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVFLTaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVFLTaz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVFLT3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:29:52 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:20497 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262657AbVFLTG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 15:06:26 -0400
Date: Sun, 12 Jun 2005 12:12:02 -0700
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrea Arcangeli <andrea@suse.de>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Bill Huey <bhuey@lnxw.com>, Karim Yaghmour <karim@opersys.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050612191202.GA27706@nietzsche.lynx.com>
References: <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <20050612170147.GE5796@g5.random> <1118601783.20671.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118601783.20671.8.camel@mindpipe>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 02:43:02PM -0400, Lee Revell wrote:
> Nforce4 chipsets have some problems that look like DMA starvation too,
> the RME people claim to have traced it to the SATA controller.
> 
> http://www.rme-audio.de/english/techinfo/nforce4_tests.htm
> 
> Basically these all fall under common sense engineering, you don't use
> buggy/unproved hardware for an RT or any mission critical system.  

How did folks work around that ? by using another SATA PCI-e card ?

bill

