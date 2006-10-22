Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423026AbWJVFsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbWJVFsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 01:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423000AbWJVFsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 01:48:09 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:53520 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1423014AbWJVFsH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 01:48:07 -0400
X-Server-Uuid: 79DB55DB-3CB4-423E-BEDB-D0F268247E63
Content-class: urn:content-classes:message
MIME-Version: 1.0
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: Re: tg3 kernel bug in 2.6.18-mm3 and 2.6.19-rc2-mm2
Date: Sat, 21 Oct 2006 22:47:52 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FC5D@NT-IRVA-0751.brcm.ad.broadcom.com>
In-Reply-To: <20061021234107.GA12918@gamma.logic.tuwien.ac.at>
Thread-Topic: tg3 kernel bug in 2.6.18-mm3 and 2.6.19-rc2-mm2
Thread-Index: Acb1aodFdQyn8TwRR36Y39HJEPrifAAMqZbQ
From: "Michael Chan" <mchan@broadcom.com>
To: "Norbert Preining" <preining@logic.at>, "Andrew Morton" <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, "David Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-WSS-ID: 6925D98038S1535194-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining wrote:
> On Sam, 21 Okt 2006, Andrew Morton wrote:
> > Can you test 2.6.19-rc2 plus the below?
> 
> 2.6.19-rc2	works
> 2.6.19-rc2+patch does not work
> 
> So it is this patch.
> 
It doesn't make any sense.  This patch is totally benign and
cannot cause the "No firmware running" and lockup that you
reported.  Can you please double-check?

