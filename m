Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWC1P22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWC1P22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWC1P22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:28:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16815 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750778AbWC1P22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:28:28 -0500
Subject: Re: Detecting I/O error and Halting System
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: zine el abidine Hamid <zine46@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060328150712.85169.qmail@web30602.mail.mud.yahoo.com>
References: <20060328150712.85169.qmail@web30602.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Mar 2006 16:36:03 +0100
Message-Id: <1143560163.17522.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-28 at 17:07 +0200, zine el abidine Hamid wrote:
> I don't think that it's a HDD problem nor a cable
> problem because the servers are new. We have tried

New. Thats another word for "untested" I believe 8)

> How can I determine the problem?

I would consult the hardware vendor

> I want to add that the HDD seems to be disconnected
> (the BIOS can't find any drive for boot) after a
> simple reset. We must switch off the servers to get
> them work again.

Thats strongly indicating a hardware problem.

> (http://www.tldp.org/LDP/lkmpg/) but how can I
> shutdown Linux from inside a module...? 

See the softdog driver for an example.

