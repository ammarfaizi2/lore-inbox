Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWBQPaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWBQPaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWBQPaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:30:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7886 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751466AbWBQPaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:30:13 -0500
Subject: Re: Fix IDE locking error.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <58cb370e0602170653g30bd36f3j4b1a0e95f64ecbeb@mail.gmail.com>
References: <20060216223916.GA8463@redhat.com>
	 <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
	 <1140186532.4283.2.camel@localhost.localdomain>
	 <58cb370e0602170653g30bd36f3j4b1a0e95f64ecbeb@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Feb 2006 15:33:24 +0000
Message-Id: <1140190404.4283.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-02-17 at 15:53 +0100, Bartlomiej Zolnierkiewicz wrote:
> Thank you but this is not a patch description, this is a recipe
> for me to spend nice friday's evening staring all over IDE code
> and making patch description myself...

Best I can do. I did the original analysis months and months ago when I
fixed up that locking. Since then there have been enough changes that it
may not be needed and I no longer remember the finer details


> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt ?


I have better things to do. If you don't want the patch the its not my
problem. I don't even use drivers/ide any more.

Alan

