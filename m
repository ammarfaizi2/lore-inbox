Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUIUH4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUIUH4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 03:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUIUH4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 03:56:49 -0400
Received: from hogthrob.ic.uva.nl ([145.18.240.233]:34952 "EHLO
	hogthrob.muppets.hoogervorst.net") by vger.kernel.org with ESMTP
	id S266894AbUIUH4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 03:56:47 -0400
From: "J.W. Hoogervorst" <J.W.Hoogervorst@uva.nl>
To: "'Prakash K. Cheemplavam'" <prakashkc@gmx.de>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Problem with sata_sil driver
Date: Tue, 21 Sep 2004 09:56:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20040920091902.110B97813B@hogthrob.muppets.hoogervorst.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcSe8Tn2AFfrsXnlQsq12Ar0ke/TFAAAZRHQAC9lIgA=
Message-Id: <20040921075643.C85A47813D@hogthrob.muppets.hoogervorst.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On my Nforce2 some 2.6.8 broke libata w/ sata_sil in non-Apic 
> > mode. With
> > Apic it worked. Try 2.6.9-rcX kernel. This one worked in both cases.
> 
> Thanks. I'll try that tonight!

Succes!

sata_sil is working like a charm with kernel 2.6.9-rc2-bk5.

Thanks!

Jeroen

