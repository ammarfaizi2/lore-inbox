Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUDAI2a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUDAI23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:28:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29453 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262773AbUDAI2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:28:17 -0500
Date: Thu, 1 Apr 2004 09:28:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David L <idht4n@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial port canonical mode weirdness?
Message-ID: <20040401092813.A20360@flint.arm.linux.org.uk>
Mail-Followup-To: David L <idht4n@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY2-F51LDp7mvjkO2200021e67@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BAY2-F51LDp7mvjkO2200021e67@hotmail.com>; from idht4n@hotmail.com on Wed, Mar 31, 2004 at 04:44:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 04:44:32PM -0800, David L wrote:
> When I configure a serial port for canonical mode (newtio.c_lflag = ICANON),
> I get behavior that isn't what I'd expect.

Can you supply the test program you're using on the receive end?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
