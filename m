Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbUJYRZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUJYRZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUJYRQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:16:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261177AbUJYROE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:14:04 -0400
Date: Mon, 25 Oct 2004 10:13:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Hanna Linder <hannal@us.ibm.com>
Subject: Re: Compile breakage from me
In-Reply-To: <417D325B.8060009@pobox.com>
Message-ID: <Pine.LNX.4.58.0410251012090.27766@ppc970.osdl.org>
References: <417D325B.8060009@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Oct 2004, Jeff Garzik wrote:
> 
> Argh, I thought GregKH had sent for_each_pci_dev()
> 
> Wearing a brown paper bag, can one of you please "cset -x" this changeset?

How about just sending me the for_each_pci_dev() macro instead?

		Linus
