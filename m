Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVL1QlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVL1QlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 11:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVL1QlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 11:41:19 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:32178 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932529AbVL1QlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 11:41:18 -0500
Date: Wed, 28 Dec 2005 17:41:55 +0100
From: DervishD <lkml@dervishd.net>
To: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
Cc: mailinglists@unix-scripts.com, linux-kernel@vger.kernel.org
Subject: Re: Memory, where's it going?
Message-ID: <20051228164155.GA498@DervishD>
Mail-Followup-To: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>,
	mailinglists@unix-scripts.com, linux-kernel@vger.kernel.org
References: <dotjb6$j8$1@sea.gmane.org> <20051228085328.GA25380@DervishD> <026801c60b8d$ef128360$6501a8c0@ndciwkst01> <20051228095512.GA25654@DervishD> <20051228080021.44263f03.Tommy.Reynolds@MegaCoder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051228080021.44263f03.Tommy.Reynolds@MegaCoder.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Tommy :)

 * Tommy Reynolds <Tommy.Reynolds@MegaCoder.com> dixit:
> Uttered DervishD <lkml@dervishd.net>, spake thus:
> > > I understand the concept and why things are cached, i've just never
> > > seen it cache this much before..
> > Swap memory is not used just when the machine has no free memory.
> > Although this is a rough explanation and doesn't describe exactly the
> > swap mechanism, some apps will remain into swap space even if there's
> > plenty of free RAM available, as long as they are not used. 
[...] 
> It is not apps that are being evicted from main memory, only some
> of their pages.

    That's why I told "rough explanation" ;) I didn't want to go into
details, although I did anyway...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
