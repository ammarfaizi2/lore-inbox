Return-Path: <linux-kernel-owner+w=401wt.eu-S965223AbXAGWKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbXAGWKT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbXAGWKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:10:18 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49304 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965223AbXAGWKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:10:17 -0500
Date: Sun, 7 Jan 2007 22:20:56 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Hiroshi Miura <miura@da-cha.org>
Cc: TAKADA <takada@mbf.nifty.com>, linux-kernel@vger.kernel.org
Subject: Re: i386,2.6 cyrix.c cann't found companion chip
Message-ID: <20070107222056.5840617c@localhost.localdomain>
In-Reply-To: <45A11900.3020302@da-cha.org>
References: <20070107094738.21919.qmail@smb516.nifty.com>
	<45A11900.3020302@da-cha.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, these chips have already been obsolete.
> There are 2 options. One is simply remove these functionality.
> The other is to move it to compile time ifdef that is off by default.

Fortunately we have pci functions for early pci accesses. I will take a
look at this as I still have a CS5520 board.

