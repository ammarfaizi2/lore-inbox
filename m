Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTEFEFD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTEFEFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:05:03 -0400
Received: from granite.he.net ([216.218.226.66]:17928 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262340AbTEFEFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:05:02 -0400
Date: Mon, 5 May 2003 21:19:29 -0700
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Wireless drivers in 2.5.69
Message-ID: <20030506041929.GA5564@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You mentioned in your changes to the wireless core for 2.5.68 that you
had sent updates for the various drivers to the different driver
maintainers.  As it looks like your changes made it into 2.5.69, but the
driver updates didn't, do you have a pointer to these updates so that
those of us with now non-working wireless cards can test them out?

Specifically, in my case I'm looking for the updates for the orinoco_pci
driver, as that has stopped working in 2.5.69, but was working just fine
in 2.5.68.

thanks,

greg k-h
