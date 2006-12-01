Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162012AbWLAVst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162012AbWLAVst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162030AbWLAVst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:48:49 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15505 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1162012AbWLAVss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:48:48 -0500
Date: Fri, 1 Dec 2006 21:55:51 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
Message-ID: <20061201215551.66b6eb60@localhost.localdomain>
In-Reply-To: <1165006694.5257.968.camel@gullible>
References: <1164998179.5257.953.camel@gullible>
	<20061201185657.0b4b5af7@localhost.localdomain>
	<1165001705.5257.959.camel@gullible>
	<20061201195337.39ed9992@localhost.localdomain>
	<1165006694.5257.968.camel@gullible>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does that change the fact it is ugly ?
> 
> No, but it does beg the question "how else can it be done"?

Agreed.
 
> Distros need a way for users to add a fixed DSDT without recompiling
> their own kernels.

Legal rights to do so aside, do they ? and if they do does it have to be
an ugly hack in the mainstream kernel. 

Alan
