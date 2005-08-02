Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVHBApc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVHBApc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVHBApc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:45:32 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:17902 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261353AbVHBAoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:44:00 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1122930581.4623.10.camel@dhcp153.mvista.com>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <20050801205208.GA20731@elte.hu>
	 <1122930581.4623.10.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 20:43:29 -0400
Message-Id: <1122943409.6759.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 14:09 -0700, Daniel Walker wrote:
> 
> You guys want me to always CC in the future? 

Yes, please CC the LKML.  I try to for all updates since I might have
done a mistake in my code that my shallow tests don't catch, and others
might. Also to let others know what I'm suggesting to Ingo so they may
comment as well. I've had some pretty good comments from people, as well
as just deeper thoughts in what's being changed.  I also try to see
what's being proposed to Ingo's patch to make sure that I understand
what my code will be depending on.

Your wakeup race patch is a perfect example of something that should
definitely be CC'd to LKML.

-- Steve


