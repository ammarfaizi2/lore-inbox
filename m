Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbVJ1JO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVJ1JO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVJ1JO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:14:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30483 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965197AbVJ1JO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:14:27 -0400
Date: Fri, 28 Oct 2005 10:14:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DRIVER MODEL: Get rid of the obsolete tri-level suspend/resume callbacks
Message-ID: <20051028091421.GJ5044@flint.arm.linux.org.uk>
Mail-Followup-To: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <11304810272893@kroah.com> <113048102730@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113048102730@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 11:30:27PM -0700, Greg KH wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> commit afe631e665d991c18e3e636b1c2455a891758760
> tree a5ee0e95290b40a8b35b1a33de7e9da5fb7df534
> parent c4438d593e764474d701af6deebbb7df567be40f
> author Russell King <rmk+kernel@arm.linux.org.uk> Thu, 27 Oct 2005 22:48:09 -0700

Greg,

When you take patches from my git repository, please ensure that
you preserve the author as is and don't use the first signed-off-by
line.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
