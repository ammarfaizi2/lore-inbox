Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285135AbRL1BBJ>; Thu, 27 Dec 2001 20:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284309AbRL1BBC>; Thu, 27 Dec 2001 20:01:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5895 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285589AbRL1BAx>; Thu, 27 Dec 2001 20:00:53 -0500
Subject: Re: [patch] SiS7012 audio driver
To: tom@infosys.tuwien.ac.at (Thomas Gschwind)
Date: Fri, 28 Dec 2001 01:11:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com (Alan Cox)
In-Reply-To: <20011228013522.A10716@infosys.tuwien.ac.at> from "Thomas Gschwind" at Dec 28, 2001 01:35:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JlYR-0007Ye-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, does anybody have a datasheet?  Currently, this driver is based
> on the fact that OSS uses the same driver for the i810 and SiS7012
> chipsets and some experimentations.

I've asked but not received

> If you have questions, recommendations, etc. please mail me directly I
> am not regularly reading the kernel mailing list.

Doug Ledford <dledford@redhat.com> is working on this driver and has
much updated the i810 support and fixed bugs. Send him a copy. Also
btw the nvidia chipset also seems to use an i810 clone

Alan
