Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVHOJ6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVHOJ6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 05:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVHOJ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 05:58:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13066 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932575AbVHOJ6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 05:58:18 -0400
Date: Mon, 15 Aug 2005 10:58:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Robert Love <rml@novell.com>
Cc: The Cutch <ttb@tentacle.dhs.org>, Mr Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add inotify & ioprio syscalls to ARM
Message-ID: <20050815105812.E19811@flint.arm.linux.org.uk>
Mail-Followup-To: Robert Love <rml@novell.com>,
	The Cutch <ttb@tentacle.dhs.org>, Mr Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1123702167.23297.4.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1123702167.23297.4.camel@betsy>; from rml@novell.com on Wed, Aug 10, 2005 at 03:29:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 03:29:27PM -0400, Robert Love wrote:
> Hey.  Attached patch adds the syscall stubs for the inotify and ioprio
> system calls to ARM.

Since I haven't had an ack from akpm, I've appled this myself.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
