Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbUKAMnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbUKAMnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUKAMgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:36:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11270 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261771AbUKAMgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:36:05 -0500
Date: Mon, 1 Nov 2004 12:35:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: janitor@sternwelten.at
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 5/8]  serial/68360serial: replace 	schedule_timeout() with msleep_interruptible()
Message-ID: <20041101123552.E3401@flint.arm.linux.org.uk>
Mail-Followup-To: janitor@sternwelten.at, akpm@osdl.org,
	linux-kernel@vger.kernel.org, nacc@us.ibm.com
References: <E1CO209-00037f-0u@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1CO209-00037f-0u@sputnik>; from janitor@sternwelten.at on Sun, Oct 31, 2004 at 12:47:12AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 12:47:12AM +0200, janitor@sternwelten.at wrote:
> Any comments would be appreciated.

Applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
