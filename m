Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTJWIdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTJWIdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:33:19 -0400
Received: from denise.shiny.it ([194.20.232.1]:1426 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S261304AbTJWIdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:33:18 -0400
Message-ID: <XFMail.20031023103313.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20031023001430.GA1837@kroah.com>
Date: Thu, 23 Oct 2003 10:33:13 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Greg KH <greg@kroah.com>
Subject: RE: [ANNOUNCE] udev 005 release
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23-Oct-2003 Greg KH wrote:

> udev is a implementation of devfs in userspace using sysfs and
> /sbin/hotplug.  It requires a 2.6 kernel to run.

Just a few dumb questions: what are those "unfixable bugs" of devfs
people was talking about ?  Other that permission management, what
is the userspace stuff for ?  Is it possible to make a disk appear
always with the same name, regardless the order it is detected in
the scsi chain (and possibly its scsi ID) ?

--
Giuliano.
