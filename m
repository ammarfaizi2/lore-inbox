Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbULBVgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbULBVgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbULBVgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:36:33 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:38379 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261770AbULBVgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:36:32 -0500
Message-ID: <41AF8AF5.6060307@verizon.net>
Date: Thu, 02 Dec 2004 16:36:53 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH/RFC] deprecate some drivers
References: <41AECCD9.40808@pobox.com>
In-Reply-To: <41AECCD9.40808@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Thu, 2 Dec 2004 15:36:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> I'm looking to eliminate some horribly broken/dup drivers.  Since 2.6 is 
> an ongoing matter, I want a 'flashing-red warning sign' that drivers 
> will soon be disappearing, rather than just killing the driver and 
> listening for the screams.
> 
> IPhase driver is broken+abandoned, and xirtulip is 
> broken+duplicate+abandoned, and are two prime candidates for my prefence 
> of handling this matter:  CONFIG_DEPRECATED.
> 

Please add digiboard to your list - duplicate+abandoned.
