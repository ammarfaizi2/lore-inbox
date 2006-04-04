Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWDDHEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDDHEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 03:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWDDHEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 03:04:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36072 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751092AbWDDHEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 03:04:30 -0400
Date: Tue, 4 Apr 2006 09:01:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt 00/02] fix wrapping of get time of day.
Message-ID: <20060404070150.GA5210@elte.hu>
References: <1144077689.21444.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144077689.21444.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Thomas,
> 
> Can you look at these next two patches to see if they are decent.

thanks, applied.

	Ingo
