Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVHPQPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVHPQPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVHPQPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:15:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11484 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030216AbVHPQPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:15:48 -0400
Date: Tue, 16 Aug 2005 18:16:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt5
Message-ID: <20050816161633.GB2826@elte.hu>
References: <20050816121843.GA24308@elte.hu> <1124206316.5764.14.camel@localhost.localdomain> <1124207046.5764.17.camel@localhost.localdomain> <1124208507.5764.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124208507.5764.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=disabled SpamAssassin version=3.0.4
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> OK, I compiled it now. Tried to boot, and it rebooted on me before 
> showing any output :-(
> 
> So I'll start debugging it, but just incase I'm not looking for 
> something that is already found, is there anything wrong with the 
> following config?

please send non-stripped .configs if possible, if you want me to try and 
reproduce your problem.

	Ingo
