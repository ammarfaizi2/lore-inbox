Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVARIcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVARIcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVARIcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:32:09 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:64737 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261183AbVARIb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:31:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16876.51577.411991.919785@xf14.local>
Date: Tue, 18 Jan 2005 09:31:53 +0100
From: Egbert Eich <eich@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Egbert Eich <eich@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vgacon fixes to help font restauration in X11
In-Reply-To: alan@lxorguk.ukuu.org.uk wrote on Monday, 17 January 2005 at 16:30:23 +0000 
References: <16867.58009.828782.164427@xf14.fra.suse.de>
	<1105745463.9839.55.camel@localhost.localdomain>
	<16875.32871.47983.655764@xf14.local>
	<1105961582.12709.51.camel@localhost.localdomain>
	<16875.52184.169399.632936@xf14.local>
	<1105979422.15109.8.camel@localhost.localdomain>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Llu, 2005-01-17 at 14:29, Egbert Eich wrote:
 > > OK, sounds promising. The changed Xserver pieces are in HEAD of the 
 > > X.Org tree. I'll see that I make the necessary adjustments to have
 > > a soft detection if you can give me a version number of the kernel
 > > which will have the new features.
 > 
 > Send a copy directly to torvalds@osdl.org and akpm@osdl.org for merging.
 > It looks fine to me. You'll need to include a "Signed-off-by: .." line
 > to indicate you are submitting it and have the rights to do so. You can
 > tag it with "Approved-by: Alan Cox <alan@redhat.com>".

Thanks, I will do that.
I have attached the patch for kernel version detection to the 
freedesktop.org bugzilla (#2277) assuming this feature will be
in the kernel starting with version 2.6.11.

 > 
 > If you mention you need to know what kernel merges it for the X11 check
 > I'm sure you'll get an answer.
 > 

OK, will do.

Thanks!
	Egbert.
