Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262831AbREVVNI>; Tue, 22 May 2001 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbREVVMI>; Tue, 22 May 2001 17:12:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39428 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262834AbREVVL7>; Tue, 22 May 2001 17:11:59 -0400
Subject: Re: alpha iommu fixes
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 22 May 2001 22:09:01 +0100 (BST)
Cc: rth@twiddle.net (Richard Henderson), andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        linux-kernel@vger.kernel.org, davem@redhat.com (David S. Miller)
In-Reply-To: <3B0ACEB1.F3806F00@mandrakesoft.com> from "Jeff Garzik" at May 22, 2001 04:40:17 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152JOn-0002Tz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ISA cards can do sg?

AHA1542 scsi for one. It wasnt that uncommon.
