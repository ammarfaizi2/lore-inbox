Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTAEV26>; Sun, 5 Jan 2003 16:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbTAEV26>; Sun, 5 Jan 2003 16:28:58 -0500
Received: from havoc.daloft.com ([64.213.145.173]:16297 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265196AbTAEV25>;
	Sun, 5 Jan 2003 16:28:57 -0500
Date: Sun, 5 Jan 2003 16:37:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: dm fs?
Message-ID: <20030105213728.GA8239@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the status of dmfs going into mainline?

I saw that Greg KH posted a patch with some corrections to dmfs for
2.5.50?

IMO it would be nice to have a kernel config option that makes the
ioctl method optional when dmfs is set to y or m in kernel config.
That will not only save a bit of code space, but it will also serve to
encourage use of dmfs.  :)

	Jeff



