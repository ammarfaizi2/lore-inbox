Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758936AbWK2XKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936AbWK2XKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758943AbWK2XKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:10:42 -0500
Received: from xenotime.net ([66.160.160.81]:33227 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1758936AbWK2XKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:10:42 -0500
Date: Wed, 29 Nov 2006 15:11:11 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: Re: Linux 2.6.19
Message-Id: <20061129151111.6bd440f9.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 14:21:21 -0800 (PST) Linus Torvalds wrote:

> 
> There it finally is (or rather - I'm currently uploading the tar-file and 
> patches, and the mirrors are hopefully busily pushing out the git tree 
> that is already updated).
> 
> There's not a lot to be said about the changes since -rc6: the shortlog 
> (appended) tells the whole story, and it's really mostly a lot of 
> one-liners or other really small changes. Bugs fixed, but nothing that 
> stands out in my mind.

What would it take to have the kernel.org web page and finger banner
give the correct version information?  (yessir, not your problem)

from http://www.kernel.org/kdist/finger_banner:

The latest stable version of the Linux kernel is:           2.6.18.3        X
The latest prepatch for the stable Linux kernel tree is:    2.6.19-rc6
The latest snapshot for the stable Linux kernel tree is:    2.6.19-rc6-git10 X
The latest 2.4 version of the Linux kernel is:              2.4.33.4
The latest prepatch for the 2.4 Linux kernel tree is:       2.4.34-pre6
The latest 2.2 version of the Linux kernel is:              2.2.26
The latest prepatch for the 2.2 Linux kernel tree is:       2.2.27-rc2
The latest -mm patch to the stable Linux kernels is:        2.6.19-rc6-mm1  X

---
~Randy
