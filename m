Return-Path: <linux-kernel-owner+w=401wt.eu-S1759890AbWLJAhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759890AbWLJAhO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 19:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759892AbWLJAhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 19:37:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45494 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759890AbWLJAhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 19:37:09 -0500
Date: Sun, 10 Dec 2006 00:44:42 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Cc: rakheshster@yahoo.com, caglar@pardus.org.tr,
       Ismail Donmez <ismail@pardus.org.tr>, linux-kernel@vger.kernel.org
Subject: Re: VCD not readable under 2.6.18
Message-ID: <20061210004442.4c6e8451@localhost.localdomain>
In-Reply-To: <20061209172332.2915.qmail@web57808.mail.re3.yahoo.com>
References: <20061209172332.2915.qmail@web57808.mail.re3.yahoo.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 09:23:32 -0800 (PST)
Rakhesh Sasidharan <rakheshster@yahoo.com> wrote:

> Infact, just inserting a CD is enough. No need for a media player to try and access the files. :)
> 
> The backend must be polling and trying to mount the disc upon insertion. Kernel 2.6.16 and before did that fine, but kernel 2.6.17 and above don't and give error messages. Which explains why downgrading the kernel solves the problem. (If it were a HAL or KDE/ GNOME problem then shouldn't downgrading the kernel *not* help?) Just thinking aloud ... 

The old kernel erroneously failed to report errors in some cases so the
answer to that bit is a definite  - no -. That side is a desktop problem.
The fact people are saying that in addition vcd players are breaking is a
bit more mysterious.
