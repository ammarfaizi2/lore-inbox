Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbTCYV6C>; Tue, 25 Mar 2003 16:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbTCYV6C>; Tue, 25 Mar 2003 16:58:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:32687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261390AbTCYV6B>;
	Tue, 25 Mar 2003 16:58:01 -0500
Date: Tue, 25 Mar 2003 15:11:32 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Fix error handling in sysfs registration
In-Reply-To: <3E767A36.5020300@us.ibm.com>
Message-ID: <Pine.LNX.4.33.0303251510400.999-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about the delay, I've been traveling..

> The cpu, memblk, and node driver/device registration should be a little 
> more clean in the way it handles registration failures.  Or at least 
> *consistent* amongst the topology elements.  Right now, failures are 
> either silent, obscure, or leave things in an inconsistent state.

Thanks. I've applied this, and will make sure it gets merged (finally).


	-pat

