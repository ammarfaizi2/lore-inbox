Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbVJ1TfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbVJ1TfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbVJ1TfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:35:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751672AbVJ1TfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:35:13 -0400
Date: Fri, 28 Oct 2005 12:34:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, david-b@pacbell.net,
       torvalds@osdl.org
Subject: Re: [PATCH] pci device wakeup flags
Message-Id: <20051028123434.09c5cb2f.akpm@osdl.org>
In-Reply-To: <20051028155044.GA11924@kroah.com>
References: <11304810221338@kroah.com>
	<11304810223093@kroah.com>
	<20051028035116.112ba2ca.akpm@osdl.org>
	<20051028155044.GA11924@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> I
>  thought that it was one of the usb patches in my tree that was causing
>  you problems.

That's a separate problem.  gregkh-usb-usb-pm-09.patch causes my x86 box to
hang partway though boot.  I drop that from -mm as well.

