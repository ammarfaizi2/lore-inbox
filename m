Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWIYV07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWIYV07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWIYV07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:26:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751444AbWIYV06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:26:58 -0400
Date: Mon, 25 Sep 2006 14:26:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Weiske <cweiske@cweiske.de>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference at
 virtual address 000,0000a
Message-Id: <20060925142630.fb39a613.akpm@osdl.org>
In-Reply-To: <451821C9.6020602@cweiske.de>
References: <45155915.7080107@cweiske.de>
	<20060923134244.e7b73826.akpm@osdl.org>
	<451677FE.2070409@cweiske.de>
	<20060924095029.0262a2c8.akpm@osdl.org>
	<4516C4B9.5010509@cweiske.de>
	<451821C9.6020602@cweiske.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 20:36:57 +0200
Christian Weiske <cweiske@cweiske.de> wrote:

> >> I assume that you have confirmed that the machine doesn't have hardware
> >> problems?  Does it run some earlier kernel OK?  
> > The disks are both fine, they worked in other pcs without problems. The
> > ide controller card also worked fine, and the motherboard is new -
> > whatever you can expect with that. Maybe the combination is the problem.
> 
> So this is definitely a hardware problem?

Is it?  I don't recall us having established that.  Does the machine run
any earlier kernel without failing?

> Which component is most likely
> to be the bad one?

Motherboard, I guess.
