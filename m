Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTLQPfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 10:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTLQPfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 10:35:13 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:60317
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264445AbTLQPfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 10:35:07 -0500
Date: Wed, 17 Dec 2003 10:42:46 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031217104246.B13292@animx.eu.org>
References: <20031212131704.A26577@animx.eu.org> <20031214144046.GA11870@win.tue.nl> <20031214112728.A8201@animx.eu.org> <20031214202741.GA11909@win.tue.nl> <brnrf5$1e3$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <brnrf5$1e3$1@gatekeeper.tmr.com>; from bill davidsen on Tue, Dec 16, 2003 at 08:55:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep me CCed

> | Yes, and that is what the kernel used to do.
> | In general, however, the answer is unreliable. 
> 
> Unless I misread his question, he didn't ask how to make it reliable,
> he just wants the partitioning software to use it. Not to use something
> he provides by hand, to ask the BIOS and use the numbers, right or
> wrong.

Correct.

> With old BIOS versions I will agree that using any other geometry, no
> matter how correct or reliable, will result in a failure to boot.
> 
> I wish I had an answer to the original question, but I don't. Fdisk
> tries to intuit what partition info if there is at least one partition
> already created, if that's the partitioning software you are already
> using, I can't offer any other help.

I pretty much summed it up in the last message I sent.

If it wasn't for what I'm doing here, I wouldn't have cared.  In some cases,
I don't even use a geometry, I just mke2fs /dev/hdx and use the whole disk. 
But that's only on machines that run linux primarily.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
