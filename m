Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUCPXUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUCPXTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:19:32 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:49723 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261806AbUCPXTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:19:04 -0500
Message-ID: <40578C04.3070202@myrealbox.com>
Date: Tue, 16 Mar 2004 15:21:40 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Broadcom gigabit solution for Jeff.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Yes it's me again, the one-and-only guy who needs to do an ifconfig down/up
cycle to get his Broadcom BCM5702 Gigabit Ethernet (rev 02) chip to work after
every reboot. (ASUS A7V8X mobo)

I just downloaded, compiled, and installed the current driver from Broadcom's
website (bcm5700-7.1.22.tar.gz) and it WORKS!  On the first try...

I admit this is the first time I've attempted this, so I can't say what exactly
fixed this long-standing bug, or when it was fixed by Broadcom.

I'm sorry I don't have the expertise to debug this problem by myself, but I
would be more than pleased to try any experiments you can think of in order
to get this annoying bug fixed.

Can you suggest any tests or patches I could try in order to fix the current
tg3 driver?  It's been almost a year now that I've been dealing with this
silly bug!  Any help would be gratefully received!

Thanks.

