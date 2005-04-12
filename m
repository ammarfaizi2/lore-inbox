Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVDLWaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVDLWaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVDLUih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:38:37 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:9696 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262212AbVDLTIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:08:34 -0400
To: jamie@shareable.org
CC: 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412171338.GA14633@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 18:13:38 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org> <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu> <20050412171338.GA14633@mail.shareable.org>
Message-Id: <E1DLQkL-0002DS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 21:08:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There was a thread a few months ago where file-as-directory was
> discussed extensively, after Namesys implemented it.  That's where the
> conversation on detachable mount points originated AFAIR.  It will
> probably happen at some point.
> 
> A nice implemention of it in FUSE could push it along a bit :)

Aren't there some assumptions in VFS that currently make this
impossible?

I'll go and find that thread.

Thanks,
Miklos
