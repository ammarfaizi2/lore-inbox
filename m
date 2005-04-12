Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVDLQ7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVDLQ7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVDLQ5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:57:31 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:36319 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262411AbVDLQzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:55:35 -0400
To: jamie@shareable.org
CC: 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412164401.GA14149@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 17:44:01 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org>
Message-Id: <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 18:55:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed, if it can be done with namespaces _and_ mounting on a file
> (that file-as-directory concept), _and_ automounting, then you could
> cd into your tgz files and others could too :)

There's still that little problem of accessing the tgz file both as a
file and a directory.  But yes.  Maybe in 10 years time :)

Miklos
