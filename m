Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757935AbWKYQEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbWKYQEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757936AbWKYQEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:04:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1487 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757935AbWKYQEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:04:21 -0500
Date: Sat, 25 Nov 2006 16:10:43 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Casey Dahlin <cjdahlin@ncsu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Overriding X on panic
Message-ID: <20061125161043.18f1b68d@localhost.localdomain>
In-Reply-To: <1164443561.3147.54.camel@laptopd505.fenrus.org>
References: <1164434093.10503.2.camel@localhost.localdomain>
	<1164443561.3147.54.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> modesettings to use can still be in userspace, the execution of the
> series of IO's would be in the kernel, and the kernel would store
> bundles of settings, including a "rescue" one, but also for
> suspend/resume...

The mode switch sequences for modern cards are a bit more hairy than
lists of I/O poking unfortunately. 
