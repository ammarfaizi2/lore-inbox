Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265075AbUD3Foe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbUD3Foe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 01:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265077AbUD3Foe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 01:44:34 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:18579 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S265075AbUD3Foc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 01:44:32 -0400
In-Reply-To: <20040430004344.663acf90.seanlkml@rogers.com>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com> <200404292347.17431.koke_lkml@amedias.org> <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com> <20040429195553.4fba0da7.seanlkml@rogers.com> <3A39091E-9A4C-11D8-B83D-000A95BCAC26@linuxant.com> <20040430004344.663acf90.seanlkml@rogers.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6FD0ADAF-9A69-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: koke@sindominio.net, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       riel@redhat.com, david@gibson.dropbear.id.au, torvalds@osdl.org,
       miller@techsource.com, paul@wagland.net
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 01:44:24 -0400
To: Sean Estabrooks <seanlkml@rogers.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Apr 30, 2004, at 12:43 AM, Sean Estabrooks wrote:
>
> Dear Marc,
>
> Who decided that the goal was to become ubiquitous at any cost?  How
> are you so sure that removing the incentive/reward for hardware vendors
> to release open source drivers is best for Linux in the long run?

There are major chipset vendors out there who have managed to become 
market leaders while not providing any drivers for Linux.

But other vendors are also still releasing new native linux drivers, 
despite the availability of our solutions (Intel's project for Centrino 
at ipw2100.sourceforge.net is a great example).

This essentially proves that we are not removing the incentive to do 
proper native drivers, simply providing more options for 1) people who 
would otherwise be stuck or unable to use the full functionality of 
their machines under Linux right now, and 2) vendors who are not able 
to afford or justify the cost of developing native linux drivers due to 
the size of the current Linux desktop market. In general these vendors 
plan to one day produce native drivers, once the numbers make it 
possible.

Marc

