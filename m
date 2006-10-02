Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWJBRUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWJBRUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWJBRUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:20:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63897 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965150AbWJBRUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:20:45 -0400
Subject: Re: [patch 2.6.18-git] ide-cs (CompactFlash) driver, rm irq warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200610020902.20030.david-b@pacbell.net>
References: <200610020902.20030.david-b@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 18:45:49 +0100
Message-Id: <1159811149.8907.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 09:02 -0700, ysgrifennodd David Brownell:
> Git rid of the runtime warning about pcmcia not supporting
> exclusive IRQs, so "the driver needs updating".
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

You've audited the code to check this is safely handled ?

