Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbTEHLxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbTEHLxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:53:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64645
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261388AbTEHLxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:53:22 -0400
Subject: Re: 2.4.21-rc boot stalls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052371307.2703.43.camel@localhost.localdomain>
References: <1052371307.2703.43.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052392048.10038.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 12:07:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 06:21, Bob Gill wrote:
> Hi. I just built 2.4.21-rc.  It hangs on boot.  More specifically, I
> get: 
> hda: (ide_dma_test_irq) called while not waiting
> blk queue c031e840
> I/O limit 4095 Mb (mask 0xffffffff)
> setting using_dma_to 1 (on)

Do you have APIC support or ACPI enabled ?

