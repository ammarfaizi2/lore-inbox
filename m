Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVIFNWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVIFNWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVIFNWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:22:09 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47005 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964868AbVIFNWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:22:07 -0400
Subject: Re: GFS, what's remainingh
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@istop.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Lars Marowsky-Bree <lmb@suse.de>, Andi Kleen <ak@suse.de>,
       linux clustering <linux-cluster@redhat.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <200509060248.47433.phillips@istop.com>
References: <20050901104620.GA22482@redhat.com>
	 <200509060058.44934.phillips@istop.com>
	 <200509060005.59578.dtor_core@ameritech.net>
	 <200509060248.47433.phillips@istop.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Sep 2005 14:42:29 +0100
Message-Id: <1126014150.22131.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-06 at 02:48 -0400, Daniel Phillips wrote:
> On Tuesday 06 September 2005 01:05, Dmitry Torokhov wrote:
> > do you think it is a bit premature to dismiss something even without
> > ever seeing the code?
> 
> You told me you are using a dlm for a single-node application, is there 
> anything more I need to know?

That's standard practice for many non-Unix operating systems. It means
your code supports failover without much additional work and it provides
all the functionality for locks on a single node too

