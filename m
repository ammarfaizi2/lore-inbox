Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVKZMd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVKZMd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 07:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVKZMd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 07:33:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:23703 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750865AbVKZMd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 07:33:57 -0500
Date: Sat, 26 Nov 2005 13:33:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>,
       Aleksey Makarov <amakarov@dev.rtsoft.ru>
Subject: Re: [PATCH -rt] convert compat sem in block device sx8
Message-ID: <20051126123353.GD3712@elte.hu>
References: <438709F5.1050801@dev.rtsoft.ru> <1132929218.11915.2.camel@localhost.localdomain> <1132959025.24417.30.camel@localhost.localdomain> <1132959475.24417.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132959475.24417.38.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 2005-11-25 at 17:50 -0500, Steven Rostedt wrote:
> > Ingo,
> > 
> > I decided to add a few more conversions to the list :-)
> > 
> > Here's sx8. Unfortunately, I was only able to test compiling it, since I
> > don't have the hardware. Hence, I'm not sending this to mainline unless
> > someone can test it on yours. (your patch is the new -mm ;-)
> > 
> 
> Ack!  I sent this after making a small change and never refreshing
> quilt.  So this would not even compile!
> 
> Here's the fixed patch:

thanks, applied.

	Ingo
