Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVG1V2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVG1V2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVG1VLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:11:46 -0400
Received: from mail1.kontent.de ([81.88.34.36]:50085 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261691AbVG1VJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:09:55 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Thu, 28 Jul 2005 23:10:22 +0200
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org
References: <20050726015401.GA25015@kroah.com> <20050728190352.GA29092@kroah.com> <9e47339105072812575e567531@mail.gmail.com>
In-Reply-To: <9e47339105072812575e567531@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507282310.23152.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 28. Juli 2005 21:57 schrieb Jon Smirl:
> New, simplified version of the sysfs whitespace strip patch...

Could you tell me why you don't just fail the operation if malformed
input is supplied?

	Regards
		Oliver
