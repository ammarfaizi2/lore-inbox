Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWAVK71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWAVK71 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 05:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAVK71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 05:59:27 -0500
Received: from elvis.mu.org ([192.203.228.196]:13267 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S932383AbWAVK70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 05:59:26 -0500
Message-ID: <43D36580.7020803@FreeBSD.org>
Date: Sun, 22 Jan 2006 02:59:12 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
CC: Herbert Poetzl <herbert@13thfloor.at>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] vfs: propagate mnt_flags into do_loopback/vfsmount
References: <20060121083843.GA10044@MAIL.13thfloor.at> <20060121084055.GC10044@MAIL.13thfloor.at> <43D3590A.2050803@FreeBSD.org>
In-Reply-To: <43D3590A.2050803@FreeBSD.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suleiman Souhlal wrote:
> Shouldn't it be retval = do_loopback(&nd, dev_name, recurse, mnt_flags); ?

Nevermind.
-- Suleiman
