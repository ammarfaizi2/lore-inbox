Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVCIXKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVCIXKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVCIXH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:07:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61835 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262373AbVCIWbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:31:40 -0500
Subject: Re: [PATCH] resync ATI PCI idents into base kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309220032.GA9289@infradead.org>
References: <200503072216.j27MGxtP024504@hera.kernel.org>
	 <20050308053941.GA16450@kroah.com>
	 <1110276929.28860.93.camel@localhost.localdomain>
	 <20050308223353.GA19278@infradead.org>
	 <1110383142.28860.184.camel@localhost.localdomain>
	 <20050309220032.GA9289@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110407386.9942.262.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 22:29:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 22:00, Christoph Hellwig wrote:
> Which is?  That's you're so special you don't need to care about the
> workflow the ordinary humans have created?

I don't see the connection between your comment and the thread sorry.

If I send it all to Andrew what will happen. Andrew can either break it
into zillions of pieces and everyone will say "But why do we need this"
or apply it. You might want to ask why so many new drivers don't bother
using pci_ids.h, I'd venture to say its a defensive mechanism against
broken process.

Alan

