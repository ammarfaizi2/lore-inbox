Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSJWQ16>; Wed, 23 Oct 2002 12:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSJWQ16>; Wed, 23 Oct 2002 12:27:58 -0400
Received: from [213.95.15.193] ([213.95.15.193]:36356 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262648AbSJWQ15>;
	Wed, 23 Oct 2002 12:27:57 -0400
To: Stephen Smalley <sds@tislabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
References: <20021023155457.L2732@redhat.com.suse.lists.linux.kernel> <Pine.GSO.4.33.0210231112420.7042-100000@raven.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Oct 2002 18:33:58 +0200
In-Reply-To: Stephen Smalley's message of "23 Oct 2002 18:11:10 +0200"
Message-ID: <p73fzuxru6h.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tislabs.com> writes:

> If we migrate SELinux to using extended attributes to store file security
> contexts (pending their merging into 2.5), 


You can already use extended attributes in 2.5. Just not with ext2/3/reiserfs
yet, only with JFS and XFS.


-Andi
