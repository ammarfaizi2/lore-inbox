Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVBQTcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVBQTcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVBQTbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:31:07 -0500
Received: from mailhub2.nextra.sk ([195.168.1.110]:47375 "EHLO toe.nextra.sk")
	by vger.kernel.org with ESMTP id S262363AbVBQTW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:22:28 -0500
Message-ID: <4214EFF5.1020902@rainbow-software.org>
Date: Thu, 17 Feb 2005 20:26:45 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>, hostap@shmoo.com
Subject: Re: 2.6.10: irq 12 nobody cared!
References: <4214450B.6090006@triplehelix.org> <Pine.LNX.4.61.0502170713110.26742@montezuma.fsmlabs.com> <4214EA6C.8040101@triplehelix.org>
In-Reply-To: <4214EA6C.8040101@triplehelix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:

> irq 12: nobody cared!
[...]
> Disabling IRQ #12
> serio: i8042 AUX port at 0x60,0x64 irq 12
                                      ^^^^^^

> mice: PS/2 mouse device common for all mice
> irq 12: nobody cared!

I'd say that there is a conflict between the card and PS/2 mouse port.

-- 
Ondrej Zary
