Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbUKRVIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUKRVIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbUKRVIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:08:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:42692 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261201AbUKRVGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:06:18 -0500
Date: Thu, 18 Nov 2004 13:06:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, hbryan@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-Id: <20041118130601.6ee8bd97.akpm@osdl.org>
In-Reply-To: <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
	<E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
	<E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
	<E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Maybe someone can help me.  Anybody who writes a program that
>  deadlocks Linux with a FUSE filesystem

Grab http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz and
learn to drive run-bash-shared-mappings.sh.

> gets a medal

My emedals.com account awaits your contribution ;)
