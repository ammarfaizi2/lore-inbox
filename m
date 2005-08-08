Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVHHSwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVHHSwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVHHSwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:52:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44043 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932195AbVHHSwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:52:13 -0400
Date: Mon, 8 Aug 2005 19:52:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jamey@handhelds.org, anpaza@mail.ru
Subject: Re: platform-device-driver-for-mq11xx-graphics-chip.patch added to -mm tree
Message-ID: <20050808195205.D12788@flint.arm.linux.org.uk>
Mail-Followup-To: Jamey Hicks <jamey.hicks@hp.com>,
	Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, jamey@handhelds.org, anpaza@mail.ru
References: <200508050719.j757J9KO032652@shell0.pdx.osdl.net> <1123228133.7649.4.camel@localhost.localdomain> <42F35BAA.1070506@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42F35BAA.1070506@hp.com>; from jamey.hicks@hp.com on Fri, Aug 05, 2005 at 08:29:30AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 08:29:30AM -0400, Jamey Hicks wrote:
> I do not have a problem with moving these drivers to drivers/mfd.  I do 
> want to have a policy that says where such drivers should go.

Well, I've recently moved the UCB1200/1300 drivers there.  See my reply
to Pavel yesterday.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
