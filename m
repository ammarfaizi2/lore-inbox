Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269399AbUIIKSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269399AbUIIKSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269401AbUIIKSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:18:44 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:35003 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269399AbUIIKSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:18:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp on x86-64 w/ nforce3
Date: Thu, 9 Sep 2004 12:19:16 +0200
User-Agent: KMail/1.6.2
Cc: Tony Lindgren <tony@atomide.com>, pavel@suse.cz, Andi Kleen <ak@suse.de>
References: <200409061836.21505.rjw@sisk.pl> <200409082252.38350.rjw@sisk.pl> <20040909011802.GN8142@atomide.com>
In-Reply-To: <20040909011802.GN8142@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409091219.17347.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 of September 2004 03:18, Tony Lindgren wrote:
> * Rafael J. Wysocki <rjw@sisk.pl> [040908 13:52]:
> > On Wednesday 08 of September 2004 22:42, Tony Lindgren wrote:
> > > 
> > > Just FYI, swsusp works nicely here on my m6805 laptop :)
> > 
> > Can you, please, send me your .config?
> 
> You can get my current m6805 .config at (I just updated it):
> 
> http://www.muru.com/linux/amd64/config
> 

Please excuse me, but Is your laptop nforce3-based?  I see that you have set 
CONFIG_BLK_DEV_VIA82CXXX rather than CONFIG_BLK_DEV_AMD74XX in the .config, 
which indicates that it's VIA-based.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
