Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVCXWQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVCXWQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVCXWQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:16:15 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:58010 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261168AbVCXWQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:16:14 -0500
To: matthias.christian@tiscali.de
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <42430BA3.5020907@tiscali.de> (message from Matthias-Christian
	Ott on Thu, 24 Mar 2005 19:49:07 +0100)
Subject: Re: [PATCH] FUSE: comments for dev.c
References: <E1DEX1K-0007MV-00@dorka.pomaz.szeredi.hu> <42430BA3.5020907@tiscali.de>
Message-Id: <E1DEacL-0007kM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 24 Mar 2005 23:15:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >This adds lots of documentation to dev.c.  This file is raised from
> >least documented to most documented status.
> >
> >Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> >[ . . . ]
> >  
> >
> Put such a big dicumentation to the documentation folder not in the code.
             ^^^^^^^^^^^^^^^^^
             That's a freudian slip or what :)

Andrew, please drop the previous patch (if you applied it already).
I'll send one that has the big part split out into
Documentation/filesystems/fuse.txt

Thanks,
Miklos
