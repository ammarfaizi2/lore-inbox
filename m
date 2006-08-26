Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWHZUSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWHZUSt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 16:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWHZUSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 16:18:49 -0400
Received: from ns.suse.de ([195.135.220.2]:37558 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750799AbWHZUSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 16:18:48 -0400
Date: Sat, 26 Aug 2006 13:18:20 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI bug fixes for 2.6.18-rc4
Message-ID: <20060826201820.GA16690@kroah.com>
References: <1156614381.3501.12.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156614381.3501.12.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 12:46:21PM -0500, James Bottomley wrote:
> This is the set of accumulated bug fixes (I'm afraid it's bigger than it
> should be on account of me missing 2.6.18-rc2.  This is basically a set
> of driver bug fixes, plus a scsi mid-layer regression fix.
> 
> The patch is here:
> 
> master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

Pulled from, and pushed out.

thanks,

greg k-h
