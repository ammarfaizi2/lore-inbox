Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUB2Tim (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 14:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUB2Tim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 14:38:42 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:34974 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S262124AbUB2Tij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 14:38:39 -0500
Subject: Re: Linux 2.6 Build System and Binary Modules
From: Larry Reaves <larry@moonshinecomputers.com>
To: Robbert Haarman <lkml@inglorion.net>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040229192034.GB8057@shire.sytes.net>
References: <20040229183143.GA8057@shire.sytes.net>
	 <Pine.LNX.4.58.0402291940110.22146@alpha.polcom.net>
	 <20040229192034.GB8057@shire.sytes.net>
Content-Type: text/plain
Message-Id: <1078083510.3942.23.camel@tux.moonshinecomputers.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 29 Feb 2004 14:38:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's were I'm stuck too...
On Sun, 2004-02-29 at 14:20, Robbert Haarman wrote:
> On Sun, Feb 29, 2004 at 07:42:45PM +0100, Grzegorz Kulewski wrote:
> > > How do I get it to link in the .o file, without making it look for the like-named .c file?
> > 
> > I do not know if it will help You, but take a look at how makefile of new 
> > nvidia driver is built... (patches from minion.de or newest driver from 
> > nvidia.com)
> 
> Thanks, I got it now. Now just to see what I can do about missing __generic_copy_to_user and ..._from_user. :-)
> 
> ---
> "One of the common denominators I have found is that expectations rise above that which is expected."
> 	-- George W. Bush
-- 
Larry Reaves <larry@moonshinecomputers.com>

