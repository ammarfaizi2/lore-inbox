Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbTLKQDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbTLKQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:03:16 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:60904 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S265130AbTLKQDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:03:15 -0500
Date: Thu, 11 Dec 2003 09:05:48 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031211160548.GA177@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au> <200312101543.39597.ross@datscreative.com.au> <Pine.LNX.4.55.0312101653490.31543@jurand.ds.pg.gda.pl> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com> <20031211145847.GA609@tesore.local> <1071156058.14260.55.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071156058.14260.55.camel@athlonxp.bradney.info>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 04:20:58PM +0100, Craig Bradney wrote:
> Not really sure what I'm looking at here but as you guys are showing
> this information I thought it might be helpful for those that can use it
> to have the information run on a Asus A7N8X Deluxe (v2.0 bios 1007) with
> Athlon XP 2600+. 
> 

Unfortunately, it looks as all our MP tables are invalid.  So I don't think we can use them.  I thought mine was especailly weird because of the Product ID seems to be pointing to a "Press Any Key" string which proves that.

Jesse
