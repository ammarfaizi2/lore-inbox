Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264874AbRGNUF0>; Sat, 14 Jul 2001 16:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264869AbRGNUFQ>; Sat, 14 Jul 2001 16:05:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14606 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264860AbRGNUFC>; Sat, 14 Jul 2001 16:05:02 -0400
Subject: Re: Linux 2.4.6-ac3
To: zvalinskas@carolina.rr.com (Zilvinas Valinskas)
Date: Sat, 14 Jul 2001 21:05:53 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010714160122.A3670@clt88-175-140.carolina.rr.com> from "Zilvinas Valinskas" at Jul 14, 2001 04:01:22 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LVfl-0001fh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These drivers are already outdated .... In order to get DRI working
> you need drivers that comes with XFree 4.1.0 (or the CVS version of
> DRI tree ....). I doubt these are worth ... fixing at all.

I've read the DRI 4.1 code. Its unreadable macro abuse. It is also a major
incompatible API change - that means its 2.5 material. At least initially

Alan

