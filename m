Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbUKLAHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbUKLAHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKLAGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:06:43 -0500
Received: from lists.us.dell.com ([143.166.224.162]:41384 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262403AbUKKW4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:56:01 -0500
Date: Thu, 11 Nov 2004 16:55:46 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Christian Kujau <evil@g-house.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@gmail.com>, Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
Message-ID: <20041111225546.GA31728@lists.us.dell.com>
References: <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de> <20041109234053.GA4546@lists.us.dell.com> <20041111224331.GA31340@lists.us.dell.com> <Pine.LNX.4.58.0411111450580.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411111450580.2301@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 02:53:15PM -0800, Linus Torvalds wrote:
> Matt, I'll revert the EXTENDED READ change for now, then. The random
> behaviour of the problem it causes makes me really dislike this bug, and
> I'd like to release a -rc2 and start calming down the 2.6.10 stuff, but
> having known random stuff happen really disturbs me.
> 
> We can re-do it once it's more obvious why it broke..

Good plan, thanks.

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
