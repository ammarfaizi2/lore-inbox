Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVBDJVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVBDJVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 04:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVBDJVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 04:21:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:59813 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262886AbVBDJUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 04:20:48 -0500
Date: Fri, 4 Feb 2005 01:20:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, mochel@digitalimplant.org
Subject: Re: Please open sysfs symbols to proprietary modules
Message-Id: <20050204012042.6aedcf39.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin <proski@gnu.org> wrote:
>
> I'm writing a module under a proprietary license.

You shouldn't, although many people do.  It's a derived work and hence the
GPL is applicable.  The only exception we make is for code which was
written for other operating systems and was then ported to Linux.  Because
it is inappropriate to consider such code a derived work.
