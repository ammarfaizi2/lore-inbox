Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTJXGoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 02:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTJXGoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 02:44:12 -0400
Received: from [66.62.77.7] ([66.62.77.7]:42972 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S262070AbTJXGoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 02:44:09 -0400
Subject: Re: [ANNOUNCE] udev 005 release
From: Dax Kelson <dax@gurulabs.com>
To: Greg KH <greg@kroah.com>
Cc: Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
In-Reply-To: <20031023232648.GA21547@kroah.com>
References: <20031023001430.GA1837@kroah.com>
	 <XFMail.20031023103313.pochini@shiny.it> <20031023232648.GA21547@kroah.com>
Content-Type: text/plain
Message-Id: <1066977848.3252.4.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Fri, 24 Oct 2003 00:44:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 17:26, Greg KH wrote:
> On Thu, Oct 23, 2003 at 10:33:13AM +0200, Giuliano Pochini wrote:
> > 
> > Is it possible to make a disk appear always with the same name,
> > regardless the order it is detected in the scsi chain (and possibly
> > its scsi ID) ?
> 
> Yes, that is one of the main reasons udev is here.
> 

On a 2.4 kernel system:

man devlabel

It allows for persistent disks. I believe udev's (2.6+) goals are
farther reaching.

I know that it exists in Red Hat Linux 9, Fedora 1.0, and RHEL3.

Dax Kelson
Guru Labs

