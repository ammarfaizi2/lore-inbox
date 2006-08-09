Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWHINq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWHINq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWHINq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:46:57 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:12552 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750780AbWHINq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:46:56 -0400
Date: Wed, 9 Aug 2006 09:31:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Theodore Tso <tytso@mit.edu>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: make 16C950 UARTs work
Message-ID: <20060809083059.GA13607@flint.arm.linux.org.uk>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060802194938.GL5972@redhat.com> <20060802201723.GC7173@flint.arm.linux.org.uk> <20060802225912.GB30457@thunk.org> <20060807232032.GA13008@adamis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807232032.GA13008@adamis.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 01:20:32AM +0200, Mathias Adam wrote:
> Are there any documents on why this was changed from 2.4 to 2.6?

Probably because 2.4 came after 2.6?  Remember that some 2.4 development
was done after the 2.5 kernel tree was forked.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
