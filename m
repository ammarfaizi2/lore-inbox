Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbULXIKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbULXIKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 03:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbULXIKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 03:10:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:64988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbULXIKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 03:10:10 -0500
Date: Fri, 24 Dec 2004 00:09:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: tabris <tabris@tabris.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/inode.c:1116 with
 2.6.10-rc{2-mm4,3-mm1}[repost]
Message-Id: <20041224000938.22b9f909.akpm@osdl.org>
In-Reply-To: <200412231923.14444.tabris@tabris.net>
References: <200412231923.14444.tabris@tabris.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tabris <tabris@tabris.net> wrote:
>
> 	Attached are the BUG reports for 2.6.10-rc2-mm4 (multiple BUG reports) 
>  and one from 2.6.10-rc3-mm1, plus dmesg from 2.6.10-rc3-mm1.

Are you using quotas?

What filesystem types are in use?
