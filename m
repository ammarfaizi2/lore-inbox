Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUDMQcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUDMQcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:32:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12215 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261425AbUDMQcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:32:14 -0400
Message-ID: <407C1601.1090207@pobox.com>
Date: Tue, 13 Apr 2004 12:32:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Andrew Morton <akpm@osdl.org>, boutcher@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ibmveth.c compilation
References: <16507.45195.148525.945019@cargo.ozlabs.ibm.com>
In-Reply-To: <16507.45195.148525.945019@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> This patch changes PCI_DMA_TODEVICE to DMA_TO_DEVICE in a couple of
> places in drivers/net/ibmveth.c, since it doesn't compile without this
> change and it does compile with it.  It also reformats a couple of
> over-long lines in the vicinity of the other changes.
> 
> Please apply.

ACK


