Return-Path: <linux-kernel-owner+w=401wt.eu-S1752809AbWLJAnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWLJAnA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 19:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbWLJAnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 19:43:00 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33306 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752809AbWLJAnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 19:43:00 -0500
Date: Sun, 10 Dec 2006 00:50:32 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rakhesh Sasidharan <rakhesh@rakhesh.com>, linux-kernel@vger.kernel.org
Subject: Re: VCD not readable under 2.6.18
Message-ID: <20061210005032.27c49500@localhost.localdomain>
In-Reply-To: <457B12A2.7090104@tmr.com>
References: <20061209172332.2915.qmail@web57808.mail.re3.yahoo.com>
	<457B12A2.7090104@tmr.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BUT TRY AGAIN" rather than a permanent error. Asking every 
> media-consious application to be rewritten is perhaps not the best 
> solution, either return another error, or return what application expect 
> (non-error but no data??)

Unfortunately nobody changed the behaviour just fixed bugs that were
hiding existing bad behaviour. Please take the polling mess up with the
HAL and KDE developers.

Alan
