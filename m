Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbUJ1UwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbUJ1UwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbUJ1UtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:49:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:54679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261740AbUJ1Un6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:43:58 -0400
Date: Thu, 28 Oct 2004 13:43:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stef van der Made <svdmade@planet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.10-rc1-mm1 compile issue
Message-ID: <20041028134351.E14339@build.pdx.osdl.net>
References: <418155F7.3010105@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <418155F7.3010105@planet.nl>; from svdmade@planet.nl on Thu, Oct 28, 2004 at 10:26:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stef van der Made (svdmade@planet.nl) wrote:
> fs/built-in.o(.text+0x7ac23): In function `drop_page':
> : undefined reference to `delete_from_page_cache'
> make: *** [.tmp_vmlinux1] Error 1

Fix was posted, try this archive link:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109887945018256&w=2

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
