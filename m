Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVAQRfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVAQRfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVAQRfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:35:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62856 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262327AbVAQRfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:35:02 -0500
Subject: Re: vgacon fixes to help font restauration in X11
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Egbert Eich <eich@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16875.52184.169399.632936@xf14.local>
References: <16867.58009.828782.164427@xf14.fra.suse.de>
	 <1105745463.9839.55.camel@localhost.localdomain>
	 <16875.32871.47983.655764@xf14.local>
	 <1105961582.12709.51.camel@localhost.localdomain>
	 <16875.52184.169399.632936@xf14.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105979422.15109.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 16:30:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 14:29, Egbert Eich wrote:
> OK, sounds promising. The changed Xserver pieces are in HEAD of the 
> X.Org tree. I'll see that I make the necessary adjustments to have
> a soft detection if you can give me a version number of the kernel
> which will have the new features.

Send a copy directly to torvalds@osdl.org and akpm@osdl.org for merging.
It looks fine to me. You'll need to include a "Signed-off-by: .." line
to indicate you are submitting it and have the rights to do so. You can
tag it with "Approved-by: Alan Cox <alan@redhat.com>".

If you mention you need to know what kernel merges it for the X11 check
I'm sure you'll get an answer.

Alan

