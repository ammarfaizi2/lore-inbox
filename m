Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVJKJMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVJKJMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 05:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVJKJMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 05:12:15 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38877 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751434AbVJKJMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 05:12:14 -0400
Date: Tue, 11 Oct 2005 11:12:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt12
Message-ID: <20051011091247.GA3198@elte.hu>
References: <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com> <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com> <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu> <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain> <20051006084920.GB22397@elte.hu> <Pine.LNX.4.58.0510061122530.418@localhost.localdomain> <20051011080151.GA27401@elte.hu> <Pine.LNX.4.58.0510110507240.1044@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510110507240.1044@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo, I keep getting a "changed soft IRQ-flags" on sysrq-b.  Would the 
> following patch be appropriate?

sure - applied.

	Ingo
