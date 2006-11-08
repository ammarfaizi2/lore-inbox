Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161311AbWKHQ5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWKHQ5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWKHQ5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:57:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:9881 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161311AbWKHQ5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:57:40 -0500
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 08 Nov 2006 17:57:39 +0100
From: "Marco Schwarz" <marco.schwarz@gmx.net>
In-Reply-To: <4551F4AD.4020401@gmail.com>
Message-ID: <20061108165739.279690@gmx.net>
MIME-Version: 1.0
References: <20061108141801.241790@gmx.net> <4551F4AD.4020401@gmail.com>
Subject: Re: Kernel error messages
To: Jiri Slaby <jirislaby@gmail.com>
X-Authenticated: #12086198
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Marco Schwarz wrote:
> > Hi,
> > 
> > with a vanilla 2.6.18.2 Kernel I get the following messages when I run a
> process with high CPU/memory consumption:
> > 
> > Nov  8 15:08:24 linux kernel: BUG: unable to handle kernel paging
> request at virtual address 6e696c43
> > Nov  8 15:08:24 linux kernel:  printing eip:
> > Nov  8 15:08:12 linux last message repeated 146 times
> 
> Which message? (some kind of cut&paste mismatch?)

I think thats from a do_vfs_lock: VFS is out of sync message which I get a lot with 2.6, never seen those with 2.4 ...

- Marco
