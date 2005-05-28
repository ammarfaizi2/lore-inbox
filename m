Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVE1KqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVE1KqY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 06:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVE1KqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 06:46:24 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:46349 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262686AbVE1KqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 06:46:18 -0400
To: hch@infradead.org
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20050528102559.GA20153@infradead.org> (message from Christoph
	Hellwig on Sat, 28 May 2005 11:25:59 +0100)
Subject: Re: FUSE inclusion?
References: <E1DbGol-0006tE-00@dorka.pomaz.szeredi.hu> <20050528102559.GA20153@infradead.org>
Message-Id: <E1DbyoI-00088C-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 28 May 2005 12:44:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, if anybody still got a problem with the current version (as in -mm
> > or released as 2.3-rc1 on SF.net), please speak up now.
> 
> FUSE_ALLOW_OTHER and FUSE_DEFAULT_PERMISSIONS are still there, and off by
> default.

Yes.  The difference between last time lays in the details of the
implementation, which is now well documented in
Documentation/filesystems/fuse.txt, and to which everybody has agreed
to.  Or am I mistaken?  Do you have any specific objection to the
security measures layed out in there?

Thanks,
Miklos
