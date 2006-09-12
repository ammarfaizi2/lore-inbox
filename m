Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWILLVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWILLVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWILLVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:21:02 -0400
Received: from chrocht.moloch.sk ([62.176.169.44]:42438 "EHLO mail.moloch.sk")
	by vger.kernel.org with ESMTP id S932249AbWILLVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:21:00 -0400
Date: Tue, 12 Sep 2006 13:20:57 +0200
From: Martin Lucina <mato@kotelna.sk>
To: linux-kernel@vger.kernel.org
Subject: Standalone PATA drivers patch for testing
Message-ID: <20060912112056.GB4789@dezo.moloch.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to help test the new libata-based PATA drivers since they solve
specific problems I've been having with my workstation hardware (Intel
ICH7 with SATA and PATA devices attached).  

Is there a way to obtain a standalone patch I can apply against a
2.6.17.X/2.6.18-rcX kernel or should I just use the -mm tree?  I grabbed
Alan's patch-2.6.17-ide1.gz way back when but this is obviously now very
much out of date.

Thanks,

-mato

