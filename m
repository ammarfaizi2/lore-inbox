Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTJZSjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbTJZSjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:39:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10883 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263396AbTJZSjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:39:17 -0500
Message-ID: <3F9C14C9.3090400@pobox.com>
Date: Sun, 26 Oct 2003 13:39:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad House <brad_mssw@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.0-test9] enable pci id for promise pdc20378 in new
 libata driver
References: <33092.68.105.173.45.1067192069.squirrel@mail.mainstreetsoftworks.com>
In-Reply-To: <33092.68.105.173.45.1067192069.squirrel@mail.mainstreetsoftworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad House wrote:
> Missing ID for the promise 20378 controller that is present on many
> x86_64 mobos. Simple patch to add it, and it's been tested and works
> fine.

You should CC the maintainer of libata :)


> The patch can be found here:
> http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-promise20378.patch
> 
> Patch/Testing done by Caleb Shay <caleb@webninja.com>

Tested in 32-bit mode or 64-bit mode?

I've gotten a report "works in 32-bit, fails in 64-bit".

	Jeff



