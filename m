Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTBKVFo>; Tue, 11 Feb 2003 16:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTBKVFB>; Tue, 11 Feb 2003 16:05:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8064
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266200AbTBKVE0>; Tue, 11 Feb 2003 16:04:26 -0500
Subject: Re: via rhine bug? (timeouts and resets)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger Luethi <rl@hellgate.ch>
Cc: Henrik Persson <nix@socialism.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030211154449.GA2252@k3.hellgate.ch>
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com>
	 <20030211154449.GA2252@k3.hellgate.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044985492.14143.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Feb 2003 17:44:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 15:44, Roger Luethi wrote:
> I have nailed down a number of problems even this patch doesn't fix,
> but it's kinda hard to build from there, since testing feedback has been
> basically zero. Pretty amazing considering how common Rhine hardware
> is. I guess I should write code for NUMA or ia64 instead, _they_ have
> testers <g>.

I'd be happy to test via-rhine stuff, but my boxes don't generally like
2.5.x so I can only usefully test 2.4.x fixes

