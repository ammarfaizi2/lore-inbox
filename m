Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268724AbUI2RCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268724AbUI2RCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbUI2RCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:02:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:27274 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268667AbUI2RBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:01:47 -0400
Subject: Re: PATCH: 3c59x 00:00:00:00:00:00 MAC failure
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <415AE866.7090007@pobox.com>
References: <20040929163023.GA17899@devserv.devel.redhat.com>
	 <20040929174530.D16537@flint.arm.linux.org.uk> <415AE866.7090007@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096473535.15905.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 16:58:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 17:52, Jeff Garzik wrote:
> > Shouldn't this be using is_valid_ether_addr() ?
> 
> Yes.

Fixed in my tree - want another diff ?

