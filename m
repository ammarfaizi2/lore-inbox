Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbTC0VSt>; Thu, 27 Mar 2003 16:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTC0VSt>; Thu, 27 Mar 2003 16:18:49 -0500
Received: from mail.mediaways.net ([193.189.224.113]:64066 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S261374AbTC0VSs>; Thu, 27 Mar 2003 16:18:48 -0500
Subject: Re: 2.4.21pre6: usb ports/mouse not detected
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: martin.zwickel@technotrend.de
Content-Type: text/plain
Organization: 
Message-Id: <1048800413.2120.2.camel@fortknox>
Mime-Version: 1.0
Date: 27 Mar 2003 22:26:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had the same problem few hours ago.
> Loading usb-ohci/ehci-hcd as a module fixed it for me ...
> But it's just a "It Works for Me(tm)" ...

I experienced exactly the same problems... and also compiling as modules
fixed it ...

Soeren.

