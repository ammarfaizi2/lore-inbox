Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUAVKXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUAVKXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:23:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56591 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266213AbUAVKW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:22:59 -0500
Date: Thu, 22 Jan 2004 10:22:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swusp acpi
Message-ID: <20040122102254.A17786@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401211143.51585.tuxakka@yahoo.co.uk> <20040122003212.GC300@elf.ucw.cz> <1074735908.1405.85.camel@laptop-linux> <20040122101555.GA200@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040122101555.GA200@elf.ucw.cz>; from pavel@ucw.cz on Thu, Jan 22, 2004 at 11:15:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 11:15:55AM +0100, Pavel Machek wrote:
> Not only serial console... Noone wrote serial port support.

Incorrect.  I never merged the changes because it's rather too hacky.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
