Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbRCERvI>; Mon, 5 Mar 2001 12:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130101AbRCERu6>; Mon, 5 Mar 2001 12:50:58 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:36384 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130079AbRCERuv>;
	Mon, 5 Mar 2001 12:50:51 -0500
Message-ID: <3AA3D180.24661D6B@sgi.com>
Date: Mon, 05 Mar 2001 09:48:48 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Annoying CD-rom driver error messages
In-Reply-To: <E14Zz5I-0007Pa-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this isnt a kernel problem, its a _very_ stupid app
---
	Must be more than one stupid app...

xena:/var/log# rpm -q magicdev
package magicdev is not installed
xena:/var/log# locate magicdev
xena:/var/log#
xena:/var/log# rpm -qa |grep -i magic
ImageMagick-5.2.6-4



-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
