Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbWHMDmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbWHMDmw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 23:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWHMDmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 23:42:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:2512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932669AbWHMDmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 23:42:51 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc3-mm2:  oops in device_bind_driver()
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
In-Reply-To: <20060812180256.445caea9.akpm@osdl.org>
References: <1155385726.6151.6.camel@Homer.simpson.net>
	 <20060812180256.445caea9.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 13 Aug 2006 05:50:34 +0000
Message-Id: <1155448234.7068.1.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 18:02 -0700, Andrew Morton wrote:

> I'd assume that you have CONFIG_PCI_MULTITHREAD_PROBE set, and

Yes.

	-Mike

