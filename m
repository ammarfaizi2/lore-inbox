Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbTBKCdh>; Mon, 10 Feb 2003 21:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbTBKCdh>; Mon, 10 Feb 2003 21:33:37 -0500
Received: from mta02ps.bigpond.com ([144.135.25.134]:8918 "EHLO
	wmailout2.bigpond.com") by vger.kernel.org with ESMTP
	id <S265798AbTBKCdg>; Mon, 10 Feb 2003 21:33:36 -0500
From: Srihari Vijayaraghavan <harisri@telstra.com>
To: linux-kernel@vger.kernel.org
Cc: harisri@bigpond.com
Message-ID: <14122914808b.14808b141229@bigpond.com>
Date: Tue, 11 Feb 2003 13:43:17 +1100
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: 2.5.60 - xscreensaver no go.
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While I can lock the screen fine (in GNOME that is), I can't unlock the 
screen (xscreen saver says my password is wrong, while it isn't). I had 
to terminate XFree86 to get back my desktop (bit of a trouble if I had 
any unsaved work on the desktop I guess).

The same functionality works fine under 2.5.59 and 2.4.latest.

I have:
XFree86 4.2.0 (the one in RH 8.0) - s3virge driver
xscreensaver-4.05-6 (the one in RH 8.0)

I can give other details such as XF86Config, dmesg etc.. on request. 
Later today I can verify this behaviour on 2 different computers (one 
using i810 driver and other using vesa driver, and may be another one 
using radeon driver).

Sorry if this is a known problem, please cc me if you can.

Thanks
Hari
harisri@bigpond.com

 

