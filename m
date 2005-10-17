Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVJQQa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVJQQa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJQQa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:30:59 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:36243 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750732AbVJQQa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:30:58 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Date: Mon, 17 Oct 2005 09:30:33 -0700
User-Agent: KMail/1.8.91
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rob@janerob.com
References: <20051015185502.GA9940@plato.virtuousgeek.org> <20051017024219.08662190.akpm@osdl.org> <4353770F.3010605@s5r6.in-berlin.de>
In-Reply-To: <4353770F.3010605@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510170930.33530.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 17, 2005 3:03 am, Stefan Richter wrote:
> Andrew Morton wrote:
> > Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> >>Of course we don't have a complete picture of which models are
> >> affected though.
> >
> > I suppose we could do both.  As people are found who need the module
> > parameter, we grab their DMI strings and add them to the table?
>
> Jesse, what DMI_PRODUCT_NAME matches your laptop?

I'll have to check when I get home, is the relevant info from the "System 
Information" section of the dmidecode output?

Jesse
