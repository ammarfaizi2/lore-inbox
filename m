Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWCIPc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWCIPc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWCIPc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:32:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750761AbWCIPc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:32:26 -0500
Date: Thu, 9 Mar 2006 10:32:12 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Matthias Schniedermeyer <ms@citd.de>
cc: Anshuman Gholap <anshu.pg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
In-Reply-To: <440EC2BA.7010108@citd.de>
Message-ID: <Pine.LNX.4.63.0603091030290.4484@cuia.boston.redhat.com>
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> 
 <20060308102731.GO27946@ftp.linux.org.uk> <ec92bc30603080252v7e795b4dm5116d4fe78f92cc7@mail.gmail.com>
 <440EC2BA.7010108@citd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006, Matthias Schniedermeyer wrote:

> But there is a planet-size catch:
> Vendors think in money. So if you have a device that is end of line most
> vendors couldn't care less if you can't use it anymore with current systems.
> Given that the vendor is still in business after all!

It's worse than that, actually.

Your old device no longer working is not a neutral thing
for the manufacturer, but actually a GOOD thing, since
you will be forced to buy a new device - one that has a
driver for a new version of the OS.

Binary only drivers are a good way to ensure that devices
become obsolete sooner than they would otherwise.  Not so
good for users, though...

-- 
All Rights Reversed
