Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVKBD3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVKBD3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 22:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVKBD3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 22:29:36 -0500
Received: from ozlabs.org ([203.10.76.45]:58858 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932249AbVKBD3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 22:29:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17256.12943.258107.529163@cargo.ozlabs.ibm.com>
Date: Wed, 2 Nov 2005 14:29:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc bug.h namespace pollution
In-Reply-To: <20051102031043.GB7992@ftp.linux.org.uk>
References: <20051101151716.GY7992@ftp.linux.org.uk>
	<17256.10342.228209.745529@cargo.ozlabs.ibm.com>
	<20051102031043.GB7992@ftp.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:

> Should be OK...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

OK, I'll put that in my powerpc-merge tree and ask Linus to pull it.
I want to do a few more cleanups on that file now that I look at it.

Thanks,
Paul.
