Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTL3BB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTL3BB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:01:28 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:37534 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264313AbTL3BB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:01:27 -0500
Message-ID: <3FF0CC02.9000508@myrealbox.com>
Date: Mon, 29 Dec 2003 16:51:14 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031229
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PS2 mouse changes for 2.6
References: <fa.fl0st45.t3auq7@ifi.uio.no> <fa.jm00pl0.5nsn3g@ifi.uio.no>
In-Reply-To: <fa.jm00pl0.5nsn3g@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Monday 29 December 2003 09:01 am, walt wrote:

>>I see no deprecation warnings when starting the kernel with
>>psmouse_noext, which I was expecting to see.

> It is emitted with KERN_WARNING severity and is not necessary seen on
> the console. Check your dmesg.

No warnings in dmesg on two different machines booted with psmouse_noext.

I am NOT complaining -- my mouse works better today than yesterday :0)

Is there anything I can do to help with this problem (?)
