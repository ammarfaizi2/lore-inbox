Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWJKRVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWJKRVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWJKRVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:21:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57282 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161087AbWJKRVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:21:35 -0400
Subject: Re: [2.6 patch] drivers/scsi/dpt_i2o.c: remove dead code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
In-Reply-To: <20061011145222.GL721@stusta.de>
References: <20061008231627.GO6755@stusta.de>
	 <1160578300.16513.15.camel@localhost.localdomain>
	 <20061011145222.GL721@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Oct 2006 18:45:54 +0100
Message-Id: <1160588754.16513.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see the point of the suggested place for the pci_dev_put()
> since pci_dev_get() has never been executed in this case, or do I miss 
> anything?

Correct, thats what I get for being away and reading 4000 emails when I
get back

Alan

