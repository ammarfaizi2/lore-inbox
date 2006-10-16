Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbWJPQBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWJPQBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWJPQBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:01:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39044 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161014AbWJPQBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:01:15 -0400
Subject: Re: [PATCH] libata-sff: Allow for wacky systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
In-Reply-To: <200610161517.k9GFHZrA006494@turing-police.cc.vt.edu>
References: <1161012290.24237.68.camel@localhost.localdomain>
	 <200610161517.k9GFHZrA006494@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 17:24:11 +0100
Message-Id: <1161015851.24237.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 11:17 -0400, ysgrifennodd Valdis.Kletnieks@vt.edu:
> Would it make sense for the printk to include a hint as to which controller
> is on crack, so on boxes with PCI_MULTITHREAD_PROBE it's easier to tell?

Probably but multithread probe is strictly for lunatics anyway ;)


Alan
