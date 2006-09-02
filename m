Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWIBQON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWIBQON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 12:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWIBQON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 12:14:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43932 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751121AbWIBQOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 12:14:11 -0400
Subject: Re: File corruption with 2940U2 SCSI card and aic7xxx driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ethan <thesyntheticsophist@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ea0b05b30609011744g1d68e964s726cf86d2e72a34b@mail.gmail.com>
References: <ea0b05b30609010905v341ba10ap5a7638e1d91faa5b@mail.gmail.com>
	 <1157151927.6271.341.camel@localhost.localdomain>
	 <ea0b05b30609011744g1d68e964s726cf86d2e72a34b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 02 Sep 2006 17:36:37 +0100
Message-Id: <1157214997.6271.385.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-01 am 17:44 -0700, ysgrifennodd Ethan:
> I'm having trouble believing that this could be a hardware problem
> because I can consistently read data from the SCSI disks, the
> corruption only seems to happen during writes.

I would actually say that is very consistent with hardware
incompatibility between the card and motherboard. I'd still like to know
what the current kernels do


-- 
VGER BF report: H 0
