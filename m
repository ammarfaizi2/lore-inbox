Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWEYAtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWEYAtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWEYAtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:49:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964803AbWEYAtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:49:40 -0400
Date: Wed, 24 May 2006 17:49:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/11] input: new force feedback interface
Message-Id: <20060524174910.5b066ee5.akpm@osdl.org>
In-Reply-To: <4474392F.1030809@gmail.com>
References: <20060515211229.521198000@gmail.com>
	<20060515211506.783939000@gmail.com>
	<20060517222007.2b606b1b.akpm@osdl.org>
	<4471E259.7080609@gmail.com>
	<4474392F.1030809@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> 
> Andrew, did you get my response?

Nope.

> I received Delivery Status Notification
> for your address:
> <copy>
> - These recipients of your message have been processed by the mail server:
> akpm@osdl.org; Failed; 5.3.0 (other or undefined mail system status)
> 
>     Remote MTA smtp.osdl.org: network error
> 
> 
>  - SMTP protocol diagnostic: 554 5.7.1 gmail.com suggested we reject
> your email: 81.228.11.120 is neither permitted nor denied by domain of
> anssi.hannula@gmail.com
> </paste>
> 

Appropriate people have been informed ;)

> 
> > 
> > BTW, what is the best way to send corrected patches for this patchset?
> > Probably as a reply to the individual patches?
> > 
> 
> Hmm, I think it is easier to just send the whole updated set...
> 
> I'm going to do all the changes discussed and then send the set probably
> tomorrow or in the weekend.
> 

Yes, that's fine.  Once patches have matured a bit, incremental (and
fine-grained) updates are preferred.  And I'll often turn
wholesale-replacement-attempts into incremental updates, so we can see what
changed.

But at this stage, rip-it-out-and-redo is fine.  Although it does help if
you can tell us which of the review comments were and were not implemented,
so we don't have to re-read the whole thing with the same level of
attention.

