Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWIUPfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWIUPfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 11:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWIUPfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 11:35:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29418 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751276AbWIUPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 11:35:50 -0400
Subject: Re: [PATCH 2.16.18] [TRIVIAL] Spelling fix: "control" instead of
	"cotrol"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Opdenacker <michael-lists@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
In-Reply-To: <200609211320.13040.michael-lists@free-electrons.com>
References: <200609211320.13040.michael-lists@free-electrons.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2006 16:59:33 +0100
Message-Id: <1158854373.11109.145.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-21 am 13:20 +0200, ysgrifennodd Michael Opdenacker:
> This patch against Linux 2.6.18 fixes a spelling mistake happening
> in the below files ("control" instead of "cotrol")
> 
> drivers/net/ne2.c: * bit by bit.  The EEPROM cotrol port at base + 0x1e has 
> the following
> mm/nommu.c: *   For tight cotrol over page level allocator and protection 
> flags
> mm/vmalloc.c: * For tight cotrol over page level allocator and protection 
> flags
> mm/vmalloc.c: * For tight cotrol over page level allocator and protection 
> flags
> mm/vmalloc.c: * For tight cotrol over page level allocator and protection 
> flags
> 
> Such comments and spelling mistakes then show up in the automatically 
> generated kernel documentation (created by "make htmldocs").
> 
> 	Michael.
> 
> --
> 
> Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

Acked-by: Alan Cox <alan@redhat.com>

