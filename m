Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUGGDCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUGGDCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 23:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbUGGDC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 23:02:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25069 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264833AbUGGDC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 23:02:29 -0400
Date: Wed, 7 Jul 2004 04:02:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ray Lee <ray-lk@madrabbit.org>
Cc: tomstdenis@yahoo.com, eger@havoc.gtf.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040707030227.GE12308@parcelfarce.linux.theplanet.co.uk>
References: <1089165901.4373.175.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089165901.4373.175.camel@orca.madrabbit.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 07:05:01PM -0700, Ray Lee wrote:
> 	[1] "The great thing about standards is that there are so many
> 	     of them to choose from."  Wish I could remember who said
> 	     that.

AST and in this case it actually doesn't apply - everything from K&R
to C99 is in agreement here.
