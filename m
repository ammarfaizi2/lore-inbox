Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWILPQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWILPQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWILPQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:16:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12714 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030214AbWILPQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:16:05 -0400
Subject: Re: Standalone PATA drivers patch for testing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Lucina <mato@kotelna.sk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060912112056.GB4789@dezo.moloch.sk>
References: <20060912112056.GB4789@dezo.moloch.sk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 16:39:25 +0100
Message-Id: <1158075565.6780.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-12 am 13:20 +0200, ysgrifennodd Martin Lucina:
> 2.6.17.X/2.6.18-rcX kernel or should I just use the -mm tree?  I grabbed
> Alan's patch-2.6.17-ide1.gz way back when but this is obviously now very
> much out of date.

Its somewhat tied to the -mm ata and scsi stuff now so the best approach
is to use -mm, or wait for 19-rc.

Alan

