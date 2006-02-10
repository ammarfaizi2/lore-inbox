Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWBJVwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWBJVwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWBJVwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:52:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8714 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932211AbWBJVwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:52:14 -0500
Date: Fri, 10 Feb 2006 21:52:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pat Gefre <pfg@sgi.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060210215206.GB30777@flint.arm.linux.org.uk>
Mail-Followup-To: Pat Gefre <pfg@sgi.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk> <20060210084445.GA1947@flint.arm.linux.org.uk> <200602101457.45847.pfg@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602101457.45847.pfg@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 02:57:45PM -0600, Pat Gefre wrote:
> Yeah this is something I should've fixed up... thanks
> 
> Acked-by: pfg@sgi.com

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
