Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWDLG3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWDLG3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWDLG3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:29:32 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14234 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932069AbWDLG3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:29:31 -0400
Date: Wed, 12 Apr 2006 08:27:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] Buggy uart (for 2.6.16)
Message-ID: <20060412062725.GC8499@elte.hu>
References: <1144676225.12145.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144676225.12145.30.camel@localhost.localdomain>
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

> Ingo,
> 
> I've noticed that you dropped my "buggy uart" patch.  Probably because 
> the 2.6.14 version would cause a deadlock on 2.6.16.  I've sent you a 
> new update, but it must have been lost in all the noise.  Here's the 
> patch again. [...]

thanks - indeed i missed your updated patch. Applied.

	Ingo
