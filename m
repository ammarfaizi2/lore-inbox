Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbULCULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbULCULd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbULCUEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:04:10 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:4024 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262497AbULCUBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:01:24 -0500
Date: Fri, 3 Dec 2004 11:59:08 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] A few misc patches for 2.6.10-rc2
Message-ID: <20041203195908.GA1178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 3 patches against the latest -bk tree (or 2.6.10-rc2).  I'm
putting them in email, as they are relativly tiny.  They do the
following:
	- fix a comment in the driver core
	- fix a memory leak in sysfs
	- add some documentation about the kernel interfaces (also
	  availble on the web at
	  http://www.kroah.com/log/linux/stable_api_nonsense.html if
	  people want to read it there.)

Please apply.

thanks,

greg k-h
