Return-Path: <linux-kernel-owner+w=401wt.eu-S1751766AbWLMXwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWLMXwV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWLMXwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:52:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35168 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751766AbWLMXwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:52:20 -0500
Date: Thu, 14 Dec 2006 00:00:31 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: tglx@linutronix.de
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061214000031.134f32a2@localhost.localdomain>
In-Reply-To: <1166051517.29505.66.camel@localhost.localdomain>
References: <20061213195226.GA6736@kroah.com>
	<Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	<1166044471.11914.195.camel@localhost.localdomain>
	<Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
	<1166048081.11914.208.camel@localhost.localdomain>
	<1166049055.29505.47.camel@localhost.localdomain>
	<1166049549.11914.218.camel@localhost.localdomain>
	<1166051517.29505.66.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see why the necessarity of a kernel stub driver is a killer
> argument. The chip internals, which companies might want to protect are
> certainly not in the interrupt registers.

So they can go off and write themselves a driver. Without putting junk in
the kernel "just in case", and if the driver and the user space code
using it are closely interdependant I'd suggest they look up the *legal*
definition of derivative work.

