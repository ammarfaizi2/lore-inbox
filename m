Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161573AbWJLK3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161573AbWJLK3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 06:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161574AbWJLK3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 06:29:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18628 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161573AbWJLK3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 06:29:01 -0400
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87hcya8fxk.fsf@sycorax.lbl.gov>
References: <87hcya8fxk.fsf@sycorax.lbl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Oct 2006 11:55:25 +0100
Message-Id: <1160650525.23731.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-11 am 18:45 -0700, ysgrifennodd Alex Romosan:
> i am not able to read movie dvd's anymore under 2.6.19-rc1. i get the
> following in the syslog:
> 
>   kernel: hdc: read_intr: Drive wants to transfer data the wrong way!
> 
> the drive in question is on a thinkpad t40:
> 
>   kernel: hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
>   kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> 
> i can read the disks under 2.6.18 so it's probably not the drive's
> fault. any ideas?

What controller is this ?

