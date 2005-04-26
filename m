Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVDZNof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVDZNof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVDZNof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:44:35 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:52708 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261487AbVDZNoc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:44:32 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH] PCI: Add pci shutdown ability
Date: Tue, 26 Apr 2005 06:44:03 -0700
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Adam Belay <ambx1@neo.rr.com>,
       Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425205536.GF27771@neo.rr.com> <20050425210631.GE3906@elf.ucw.cz>
In-Reply-To: <20050425210631.GE3906@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504260644.03627.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 2:06 pm, Pavel Machek wrote:

> Yes. (Actually I'm not sure if PMSG_FREEZE or PMSG_SUSPEND is right
> thing to do for suspend.)

Until they have different values, it's a moot point isn't it?
