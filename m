Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbUANUY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUANUY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:24:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44817 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264437AbUANUY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:24:57 -0500
Date: Wed, 14 Jan 2004 20:24:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PROBLEM] ircomm ioctls
Message-ID: <20040114202451.B3665@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040113181034.GA9960@bougret.hpl.hp.com> <20040113182955.F7256@flint.arm.linux.org.uk> <20040114193804.GA21754@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040114193804.GA21754@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Wed, Jan 14, 2004 at 11:38:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:38:04AM -0800, Jean Tourrilhes wrote:
> 	By the way, are you sending this patch as part of your mega
> patch or do you want me to send it ? I just want to avoid patch
> collision ;-)

I'd prefer these patches to go via the maintainers themselves.
Also, the patch looks fine from my perspective.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
