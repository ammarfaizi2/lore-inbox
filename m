Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285456AbRLNSlU>; Fri, 14 Dec 2001 13:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285457AbRLNSlK>; Fri, 14 Dec 2001 13:41:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2052 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285456AbRLNSk5>; Fri, 14 Dec 2001 13:40:57 -0500
Subject: Re: Question regarding limit on the number of sockets?
To: tschenk@origin.ea.com
Date: Fri, 14 Dec 2001 18:50:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <INSIGHT.2.6.Linux-2.4.16.01121411403821.24988@bagend.origin.ea.com> from "Thomas Schenk" at Dec 14, 2001 05:40:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ExPX-0001Be-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1.  Is this a per process limit, a per user limit, or a system wide
> limit?

per process 1024 filehandles

> 2.  Does this limit apply to both the 2.2.x and 2.4.x kernels?

Yes

> 3.  Is this limit tunable (either by patching the kernel or otherwise)?

Tunable in 2.4
