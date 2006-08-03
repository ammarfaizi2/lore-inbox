Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWHCNCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWHCNCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWHCNCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:02:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33231 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932442AbWHCNCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:02:10 -0400
Subject: Re: A proposal - binary
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
In-Reply-To: <44D1CC7D.4010600@vmware.com>
References: <44D1CC7D.4010600@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 14:21:12 +0100
Message-Id: <1154611272.23655.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So how does this differ from the twice yearly recycling of the fixed
driver ABI discussion ?

We have a facility for loading binary blobs into the kernel built from
source, its called insmod. 

Alan
