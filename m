Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTE0U5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTE0U5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:57:16 -0400
Received: from lns-th2-12-82-64-181-234.adsl.proxad.net ([82.64.181.234]:55023
	"EHLO tethys.solarsys.org") by vger.kernel.org with ESMTP
	id S264143AbTE0U5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:57:15 -0400
Date: Tue, 27 May 2003 23:10:26 +0200
From: wwp <subscript@free.fr>
To: Hans-Georg Thien <1682-600@onlinehome.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh
 aPS/2 Trackpad
Message-Id: <20030527231026.6deff7ed.subscript@free.fr>
In-Reply-To: <3ED3CECA.9020706@onlinehome.de>
References: <3EB19625.6040904@onlinehome.de>
	<3EBAAC12.F4EA298D@hp.com>
	<3ED3CECA.9020706@onlinehome.de>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans-Georg Thien,


On Tue, 27 May 2003 22:47:06 +0200 Hans-Georg Thien <1682-600@onlinehome.de>
wrote:

> Hans-Georg Thien wrote:
[snip]
> It it is now possible to adjust some settings via
> 
>        echo ???? > /proc/tty/ps2-trackpad
> 
> (1) Set the delay time to 2 Secs (default is 10 ==> 1 Sec)
> 
>          echo "delay 20" > /proc/tty/ps2-trackpad
> 
> 
> (2)  Completely disable the trackpad (default 0). Useful if you plug in 
> an external mouse.
> 
>          echo "disable 1" > /proc/tty/ps2-trackpad
> 
> (3)  Escape the keyboard scancode for a key. These scancodes are
[snip]

Sounds good, thanx for your work, guy :-).
Do you think/know if this patch will be merged to the official tree?


Regards,

-- 
wwp
