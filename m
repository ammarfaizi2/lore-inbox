Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUKTJek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUKTJek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 04:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUKTJej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 04:34:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7430 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261482AbUKTJeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 04:34:25 -0500
Date: Sat, 20 Nov 2004 09:34:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: janitor@sternwelten.at
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 2/8]  pcmcia/yenta_socket: 	replace schedule_timeout() with msleep()
Message-ID: <20041120093413.B7482@flint.arm.linux.org.uk>
Mail-Followup-To: janitor@sternwelten.at, akpm@osdl.org,
	linux-kernel@vger.kernel.org, nacc@us.ibm.com
References: <E1CO1zz-0002xy-38@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1CO1zz-0002xy-38@sputnik>; from janitor@sternwelten.at on Sun, Oct 31, 2004 at 12:47:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 12:47:02AM +0200, janitor@sternwelten.at wrote:
> Any comments would be appreciated.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
