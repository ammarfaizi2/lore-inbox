Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271368AbTGWWmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTGWWlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:41:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41480 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271374AbTGWWlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:41:05 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Make menuconfig broken
Date: 23 Jul 2003 22:48:40 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfn3c8$lnq$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0307221146120.714-100000@serv> <Pine.LNX.4.44.0307221735160.5483-100000@phoenix.infradead.org> <20030722191746.A13975@infradead.org>
X-Trace: gatekeeper.tmr.com 1059000520 22266 192.168.12.62 (23 Jul 2003 22:48:40 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030722191746.A13975@infradead.org>,
Christoph Hellwig  <hch@infradead.org> wrote:
| On Tue, Jul 22, 2003 at 05:47:04PM +0100, James Simmons wrote:
| > What about the keyboard being built in. People will still not set that. 
| 
| Why not?  With this change they will get asked for keyboard support now.
| Now that they actually are asked we can expect them to give the proper
| answer.

If the user selects an Intel CPU why isn't the typical PC setup set by
default? Time to stop pretending that there are enough non-PC setups to
justify having these choices done manually each time, and make the PC
the default Intel config.

Anyone running other is going to have to do a bunch of configs anyway.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
