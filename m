Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWJJVBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWJJVBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWJJVBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:01:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030369AbWJJVBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:01:17 -0400
Date: Tue, 10 Oct 2006 14:00:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>,
       James K Lewis <jklewis@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/21]: powerpc/cell spidernet bugfixes, etc.
Message-Id: <20061010140037.274d2c6f.akpm@osdl.org>
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 15:49:47 -0500
linas@austin.ibm.com (Linas Vepstas) wrote:

> 
> Andrew, please apply/forward upstream.

s/Andrew/Jeff/;)

> I tried to base these on linux-2.6.19-rc1-mm1 but hit a 
> kernel BUG in copy_fdtable at fs/file.c:138! 
> (reported earlire today by Olof)

yup,
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/hot-fixes/
holds what should be a fix.

