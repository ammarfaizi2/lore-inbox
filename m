Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWEDHtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWEDHtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWEDHtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:49:23 -0400
Received: from ns.suse.de ([195.135.220.2]:3974 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750918AbWEDHtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:49:22 -0400
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Date: Thu, 4 May 2006 09:49:10 +0200
User-Agent: KMail/1.9.1
Cc: Nathan Becker <nathanbecker@gmail.com>,
       David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com> <2151339d0605032152g64ec77bfhe90dc08180463c31@mail.gmail.com> <20060504052751.GA23054@kroah.com>
In-Reply-To: <20060504052751.GA23054@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605040949.11010.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 May 2006 07:27, Greg KH wrote:

> Andi, you remember what fixed this the last time?

IIRC there wasn't a fix - just a conclusion that in one case it was likely
a bad interaction with SMM code. In the other case we didn't get that far.

-Andi
