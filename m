Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbUJYSES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUJYSES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUJYSD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:03:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:11431 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261164AbUJYRZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:25:30 -0400
Date: Mon, 25 Oct 2004 10:25:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Hanna Linder <hannal@us.ibm.com>
Subject: Re: Compile breakage from me
In-Reply-To: <Pine.LNX.4.58.0410251012090.27766@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410251024290.27766@ppc970.osdl.org>
References: <417D325B.8060009@pobox.com> <Pine.LNX.4.58.0410251012090.27766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Oct 2004, Linus Torvalds wrote:
> 
> How about just sending me the for_each_pci_dev() macro instead?

Never mind. I just picked it up directly from my kernel mailing list
archives instead - Hanna had already signed off on it.

		Linus
