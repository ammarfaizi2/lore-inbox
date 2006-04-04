Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWDDHFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWDDHFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 03:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWDDHFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 03:05:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:32470 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751420AbWDDHFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 03:05:04 -0400
Date: Tue, 4 Apr 2006 09:02:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] have highres runqueue adjust_prio
Message-ID: <20060404070238.GB5210@elte.hu>
References: <1144080438.24581.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144080438.24581.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Currently, the low res runqueue in hrtimers calls adjust prio, but the 
> high res does not.

thanks, applied.

	Ingo
