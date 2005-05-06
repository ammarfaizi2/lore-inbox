Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVEFIKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVEFIKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 04:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVEFIKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 04:10:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:15316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261170AbVEFIKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 04:10:13 -0400
Date: Fri, 6 May 2005 01:10:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Greg KH <greg@kroah.com>,
       joecool1029@gmail.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Message-ID: <20050506081009.GX23013@shell0.pdx.osdl.net>
References: <d4757e6005050219514ece0c0a@mail.gmail.com> <20050503031421.GA528@kroah.com> <20050502202620.04467bbd.rddunlap@osdl.org> <20050506080056.GD4604@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506080056.GD4604@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer (aebr@win.tue.nl) wrote:
> No, there is no problem but an intentional change in behaviour in -mm
> and now also in 2.6.11.8.

I think this should be backed out of -stable.
