Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbUKAMgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbUKAMgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKAMgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:36:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8710 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261767AbUKAMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:35:49 -0500
Date: Mon, 1 Nov 2004 12:35:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: janitor@sternwelten.at
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 3/8]  serial/pmac_zilog: replace 	schedule_timeout() with msleep()
Message-ID: <20041101123518.C3401@flint.arm.linux.org.uk>
Mail-Followup-To: janitor@sternwelten.at, akpm@osdl.org,
	linux-kernel@vger.kernel.org, nacc@us.ibm.com
References: <E1CO202-00030e-8U@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1CO202-00030e-8U@sputnik>; from janitor@sternwelten.at on Sun, Oct 31, 2004 at 12:47:05AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 12:47:05AM +0200, janitor@sternwelten.at wrote:
> Any comments would be appreciated.

Applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
