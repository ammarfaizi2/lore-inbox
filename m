Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUCHUkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUCHUkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:40:04 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:7296 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261207AbUCHUj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:39:58 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Paul Jackson <pj@sgi.com>, kangur@polcom.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>
	<200403031829.41394.mmazur@kernel.pl>
	<m3brnc8zun.fsf@defiant.pm.waw.pl>
	<200403042149.36604.mmazur@kernel.pl>
	<m3brnb8bxa.fsf@defiant.pm.waw.pl>
	<Pine.LNX.4.58.0403060022570.5790@alpha.polcom.net>
	<m38yidk3rg.fsf@defiant.pm.waw.pl>
	<20040306171535.5cbf2494.pj@sgi.com>
	<m38yiclby8.fsf@defiant.pm.waw.pl>
	<20040307172847.46708dcc.pj@sgi.com>
	<m3hdwzwfcp.fsf@defiant.pm.waw.pl>
	<404C932B.8050307@nortelnetworks.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 08 Mar 2004 21:27:23 +0100
In-Reply-To: <404C932B.8050307@nortelnetworks.com> (Chris Friesen's message
 of "Mon, 08 Mar 2004 10:37:15 -0500")
Message-ID: <m33c8jhyok.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> Generally it cannot be caused by changing kernel config (although
> kernel config can cause syscalls to be valid or not).
>
> However, new kernel versions can add/remove stuff.  Usually stuff
> isn't removed for a while after its deprecated, but there have been
> instances where stuff has been added/changed/removed during unstable
> kernel development.

Well, _this_ fits nicely my own idea of the situation.
-- 
Krzysztof Halasa, B*FH
