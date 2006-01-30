Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWA3SCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWA3SCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWA3SCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:02:49 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45715 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964852AbWA3SCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:02:48 -0500
Subject: Re: License oddity in some m68k files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Waddel <Matt.Waddel@freescale.com>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <43D17F4D.2010003@freescale.com>
References: <43D17F4D.2010003@freescale.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Jan 2006 18:03:51 +0000
Message-Id: <1138644231.31089.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-20 at 17:24 -0700, Matt Waddel wrote:
> I have been given permission to fix the "UNPUBLISHED PROPRIETARY
> SOURCE CODE OF MOTOROLA ..." section in the source files of fpsp040/
> directory.
> 
> One suggestion, so we don't have to revisit this topic in 16 years
> from now again, shouldn't we just remove the UNPUBLISHED ... comment
> altogether and replace it with Greg Kroah-Hartman's suggested verbiage
> as in the patch below?

Looks sensible (sorry was a bit busy) and now catching up on email. Does
need a "signed-off-by:" line.


Thanks
Alan

