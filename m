Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbVCJUFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbVCJUFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbVCJUAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:00:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33291 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262856AbVCJTxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:53:30 -0500
Date: Thu, 10 Mar 2005 19:53:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: Someting's busted with serial in 2.6.11 latest
Message-ID: <20050310195326.A1044@flint.arm.linux.org.uk>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net>; from shemminger@osdl.org on Wed, Mar 09, 2005 at 03:50:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 03:50:49PM -0800, Stephen Hemminger wrote:
> Some checkin since 2.6.11 has caused the serial driver to
> drop characters.  Console output is chopped and messages are garbled.
> Even the shell prompt gets truncated.

There was a problem with 2.6.11-bk1 which should now be resolved.

Is this still true of the latest bk kernel?  Also, seeing the kernel
messages may provide some hint.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
