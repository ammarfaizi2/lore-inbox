Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUEXQpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUEXQpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUEXQpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:45:51 -0400
Received: from web12308.mail.yahoo.com ([216.136.173.106]:34177 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263301AbUEXQpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:45:50 -0400
Message-ID: <20040524164550.11639.qmail@web12308.mail.yahoo.com>
Date: Mon, 24 May 2004 09:45:50 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Re: x86_64 and ioctls from 32 bit userland
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0405211854590.1296@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> On Fri, 21 May 2004, Stephen Cameron wrote:
[...]
> 
> Yes. The user-mode 32-bit pointer within a structure is no different
> than passing a 32-bit user-mode pointer as the third parameter to
> an ioctl(fd, WHAT, ptr).
> 

Thanks, I've got it working now.

-- steve


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
