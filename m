Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030675AbWAJXBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030675AbWAJXBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030676AbWAJXBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:01:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:26055 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030675AbWAJXBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:01:13 -0500
Date: Tue, 10 Jan 2006 15:00:09 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: latest -git kernels available for Gentoo
Message-ID: <20060110230009.GA24268@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like I mentioned in the middle of another thread here on lkml, I was
going to work on providing easy access to the latest kernel -git tree
for Gentoo users.

Well, now there is a kernel package called 'git-sources' that you can
install that will provide this.  It should be updated every morning (my
time zone, not necessarily yours), with the latest nightly -git kernel
snapshot.

If you have any problems with the ebuild itself, please let me know.  If
you have problems with the kernel that you build from this package,
address that info to this list like any other kernel issue/bug.

thanks,

greg k-h
