Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130306AbRCBEUd>; Thu, 1 Mar 2001 23:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130307AbRCBEUY>; Thu, 1 Mar 2001 23:20:24 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:2247 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S130306AbRCBEUE>;
	Thu, 1 Mar 2001 23:20:04 -0500
Message-ID: <3A9F1F71.382A8339@mirai.cx>
Date: Thu, 01 Mar 2001 20:20:01 -0800
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Subject: Re: 2.4.2ac8 lost char devices
In-Reply-To: <Pine.LNX.4.10.10103012127050.4143-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

> > > > > > Well, somethig has broken in ac8, because I lost my PS/2 mouse and
> > > > > me too </aol>.
> > No luck.

same here -

> it seems to be the mdelay(2) added to pc_keyb.c in -ac6.

-ac7 is fine here, but when I boot -ac8, there's no ps/2 mouse.

jjs



