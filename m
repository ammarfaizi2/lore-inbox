Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWJVTti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWJVTti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWJVTti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:49:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33759 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751022AbWJVTth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:49:37 -0400
Subject: Re: [PATCH] pata_marvell: switch to pci_iomap as Jeff asked
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <453A7A4C.3090808@pobox.com>
References: <1161192357.9363.101.camel@localhost.localdomain>
	 <453A7A4C.3090808@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Oct 2006 20:51:13 +0100
Message-Id: <1161546674.1919.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-21 am 15:51 -0400, ysgrifennodd Jeff Garzik:
> Please provide code that links successfully, and compiles without 
> obvious warnings.  pci_ioremap() does not exist; you wanted pci_iomap().

Sent you the wrong diff, sorry


