Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270256AbRHWUHS>; Thu, 23 Aug 2001 16:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270195AbRHWUHI>; Thu, 23 Aug 2001 16:07:08 -0400
Received: from stat8.steeleye.com ([63.113.59.41]:35845 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S270256AbRHWUGx>; Thu, 23 Aug 2001 16:06:53 -0400
Message-ID: <3B8561E2.DE166AD8@SteelEye.com>
Date: Thu, 23 Aug 2001 16:04:50 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: gcc bug causing problem in kernel builds
In-Reply-To: <E15a0eY-0004U3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
 
> gcc 2.96-54 had plenty of bugs, 2.96-75+ should be perfectly fine for
> all uses. 

Uh oh... the gcc 2.96 I'm using is:

# rpm -q gcc
gcc-2.96-81

> If you have a 2.96 RH problem please report it in Red Hat
> bugzilla

Will do.


Thanks,
Paul

Paul.Clements@SteelEye.com
