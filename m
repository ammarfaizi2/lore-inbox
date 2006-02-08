Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbWBHWar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbWBHWar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWBHWaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:30:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:52661 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965206AbWBHWaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:30:46 -0500
Subject: Re: sound problem on recent PowerBook5,8 MacRISC3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060208160002.GI5538@washoe.onerussian.com>
References: <20060208160002.GI5538@washoe.onerussian.com>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 09:29:10 +1100
Message-Id: <1139437750.5003.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 11:00 -0500, Yaroslav Halchenko wrote:
> Dear Kernel People,
> 
> Sound fails to work on the PowerBook laptop
> information on which could be found from
> http://www.onerussian.com/Linux/bugs/bug.sound/
> 
> On 2.6.16-rc1 and got
> dmasound_pmac: couldn't find a Codec we can handle
> ....
> snd: Unknown layout ID 0x52
> (and ALSA failed to find any device)

The sound chipset on these new machines isn't yet supported.

Ben.


