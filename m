Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263451AbVCMId7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbVCMId7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 03:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbVCMId7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 03:33:59 -0500
Received: from mail.suse.de ([195.135.220.2]:64928 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263451AbVCMIdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 03:33:18 -0500
Date: Sun, 13 Mar 2005 09:33:17 +0100
From: Olaf Hering <olh@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] be more verbose in gen-devlist
Message-ID: <20050313083317.GB26100@suse.de>
References: <20050311192858.GA11077@suse.de> <20050312203642.GC11865@kroah.com> <20050313081709.GA26100@suse.de> <20050313082736.GA21182@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050313082736.GA21182@kroah.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Mar 13, Greg KH wrote:

> On Sun, Mar 13, 2005 at 09:17:09AM +0100, Olaf Hering wrote:
> >  On Sat, Mar 12, Greg KH wrote:
> > 
> > > Why #if this?  Why not just always do this?
> > 
> > Because it always triggers with current sf.net snapshot.
> 
> Someone said they were going to submit those shorter strings that the
> kernel has, back to sf.net.  Guess that didn't happen yet, and is the
> main reason I can't just sync up all the time with that repository.

I did update the database a few days ago.
