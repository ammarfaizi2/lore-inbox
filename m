Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274936AbTGaXVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274939AbTGaXV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:21:26 -0400
Received: from aneto.able.es ([212.97.163.22]:10388 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S274936AbTGaXSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:18:52 -0400
Date: Fri, 1 Aug 2003 01:18:50 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: [OT] Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-ID: <20030731231850.GC7378@werewolf.able.es>
References: <20030731224604.GA24887@tsunami.ccur.com> <1059692548.931.329.camel@localhost> <20030731230635.GA7852@rudolph.ccur.com> <1059693499.786.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1059693499.786.1.camel@localhost>; from rml@tech9.net on Fri, Aug 01, 2003 at 01:18:19 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.01, Robert Love wrote:
> On Thu, 2003-07-31 at 16:06, Joe Korty wrote:
> 
> > It's not all system daemons, just some of them that need protection.
> > 
> > Keeping the set of locked-down daemons to the smallest possible is
> > important when one wants to 'set aside' cpus for use only by
> > specific, need-the-lowest-latency-possible realtime applications.
> 
> Yah, I know. But this is a lot of code just to prevent root from hanging
> herself, and she has plenty of other ways with which to do that.
> 

Er, why 'she' ?
In spanish we use root==admin as male, and root==tree or plant root,
as female.

Any pointer (like those of jargon dictionaries) ?

TIA ;)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like
sex:
werewolf.able.es                         \           It's better when it's
free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre9-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.7mdk))
