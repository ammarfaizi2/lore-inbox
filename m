Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbUJ1V5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbUJ1V5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUJ1Vyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:54:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:21965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262964AbUJ1Vyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:54:33 -0400
Date: Thu, 28 Oct 2004 14:54:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stef van der Made <svdmade@planet.nl>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.10-rc1-mm1 compile issue
Message-ID: <20041028145428.E2357@build.pdx.osdl.net>
References: <418155F7.3010105@planet.nl> <20041028134351.E14339@build.pdx.osdl.net> <4181660C.3080202@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4181660C.3080202@planet.nl>; from svdmade@planet.nl on Thu, Oct 28, 2004 at 11:35:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stef van der Made (svdmade@planet.nl) wrote:
> I've tried the patch but it failed to apply. By the looks of the code 
> the patch was already applied. It looks like a new issue :-(

If you look carefully, that message should mention "patch -R" to back out the
change.  I should've been more explicit about that.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
