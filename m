Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbVKBQvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVKBQvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVKBQvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:51:22 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:33187 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965128AbVKBQvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:51:21 -0500
Date: Wed, 2 Nov 2005 08:51:31 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] additional -rt RCU usage fixes
Message-ID: <20051102165131.GC9915@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051101170153.GA6564@us.ibm.com> <20051102131229.GB11621@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102131229.GB11621@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 02:12:29PM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > Hello!
> > 
> > I guess I need to be more careful when creating experimental RCU 
> > patches, as people have been copying my mistakes.  Here is a patch to 
> > fix some of them in -rt.
> 
> thanks, applied - will show up in -rt3. Should be done for -mm too, 
> which now includes rcu-signal-handling.patch?

I believe it should.  I will submit any needed catch-up patches against
2.6.14-mm1 when it appears.

							Thanx, Paul
