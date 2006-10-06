Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422974AbWJFVWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974AbWJFVWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWJFVWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:22:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3013 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932636AbWJFVWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:22:45 -0400
Subject: Re: [git-or-PATCH] IRQ handler cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20061006193438.GA10730@havoc.gtf.org>
References: <20061006193438.GA10730@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 22:48:15 +0100
Message-Id: <1160171295.12835.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alan Cox <alan@redhat.com>

All looks ok, the bigger change in riscom8 is verifiably safe too

