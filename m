Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVEJNV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVEJNV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVEJNV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:21:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:7328 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261634AbVEJNVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:21:54 -0400
Date: Tue, 10 May 2005 15:21:53 +0200
From: Andi Kleen <ak@suse.de>
To: Bernd Paysan <bernd.paysan@gmx.de>
Cc: Andi Kleen <ak@suse.de>, suse-amd64@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Message-ID: <20050510132153.GJ25612@wotan.suse.de>
References: <200505081445.26663.bernd.paysan@gmx.de> <200505101355.00341.bernd.paysan@gmx.de> <20050510130709.GI25612@wotan.suse.de> <200505101515.56177.bernd.paysan@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505101515.56177.bernd.paysan@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 03:15:44PM +0200, Bernd Paysan wrote:
> On Tuesday 10 May 2005 15:07, Andi Kleen wrote:
> > That could be irqbalance doing its thing. Does it go away when
> > you stop it?
> 
> Yes, it seems to go away.

Ok, it is fine then. A bit unexpected, but fine.

-Andi
