Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266106AbTGNTSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270744AbTGNTSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:18:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3793 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266106AbTGNTSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:18:22 -0400
Date: Mon, 14 Jul 2003 12:25:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       alan@lxorguk.ukuu.org.uk, hch@infradead.org, greg@kroah.com,
       chris@wirex.com, jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SELinux module to 2.6.0-test1
Message-Id: <20030714122542.52c46094.akpm@osdl.org>
In-Reply-To: <1058209504.13738.687.camel@moss-huskers.epoch.ncsc.mil>
References: <1058209504.13738.687.camel@moss-huskers.epoch.ncsc.mil>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@epoch.ncsc.mil> wrote:
>
> The patch available from
> http://www.nsa.gov/selinux/lk/2.6.0-test1-addselinux.patch.gz adds the
> SELinux module under security/selinux and modifies the security/Makefile
> and security/Kconfig files for SELinux.

I'll drop this into -mm, take a look at it.

The diff adds five or six hundred lines-with-trailing-whitespace, which I
trimmed off.

