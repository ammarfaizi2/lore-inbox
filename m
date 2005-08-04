Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVHDNom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVHDNom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVHDNom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:44:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9744 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262532AbVHDNng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:43:36 -0400
Date: Thu, 4 Aug 2005 14:43:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Old api files, rewrite or delete?
Message-ID: <20050804144331.E32154@flint.arm.linux.org.uk>
Mail-Followup-To: Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42F20345.3020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42F20345.3020603@gmail.com>; from jirislaby@gmail.com on Thu, Aug 04, 2005 at 02:00:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 02:00:05PM +0200, Jiri Slaby wrote:
> drivers/parport/parport_pc.c

I think a fair number of people probably use this.

> REMOVE:
> drivers/video/pm3fb.c

I have one of these cards, and I believe it's only recently (2.5-ish)
been merged.  Why are you so keen to mark it as "remove"?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
