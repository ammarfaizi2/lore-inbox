Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVECEXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVECEXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 00:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVECEXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 00:23:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:4044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261381AbVECEXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 00:23:00 -0400
Date: Mon, 2 May 2005 21:24:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Bill Davidsen <davidsen@tmr.com>, Morten Welinder <mwelinder@gmail.com>,
       Sean <seanlkml@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <20050503000011.GA22038@waste.org>
Message-ID: <Pine.LNX.4.58.0505022123270.3594@ppc970.osdl.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com>
 <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org>
 <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org> <20050503000011.GA22038@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 May 2005, Matt Mackall wrote:
> 
> It's still simple in Mercurial, but more importantly Mercurial _won't
> need it_. Dropping history is a work-around, not a feature.

Side note: this is what Larry thought about BK too. Until three years had
passed, and the ChangeSet file was many megabytes in size. Even slow
growth ends up being big growth in the end..

We had been talking about pruning the BK history as long back as a year 
ago.

		Linus
