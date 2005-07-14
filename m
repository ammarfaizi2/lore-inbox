Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVGNQ3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVGNQ3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVGNQ3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:29:00 -0400
Received: from mail.cipsoft.com ([62.146.47.42]:16353 "EHLO mail.cipsoft.com")
	by vger.kernel.org with ESMTP id S261822AbVGNQ1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:27:11 -0400
Message-ID: <42D69255.2060900@cipsoft.com>
Date: Thu, 14 Jul 2005 18:27:01 +0200
From: Thoralf Will <thoralf@cipsoft.com>
Organization: CipSoft GmbH
User-Agent: Mozilla Thunderbird 1.0.2-1.4.1.centos4 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pc_keyb: controller jammed (0xA7)
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I didn't find any useful answer anywhere so far, hope it's ok to ask here.
I'm currently trying to get a 2.4.31 up and running on an IBM
BladeCenter HS20/8843. (base system is a stripped down RH9)

When booting the kernel the console is spammmed with:
   pc_keyb: controller jammed (0xA7)
But it seems there are no further consequences and the keyboard is
working. The only answer I've found is "disable usb legacy" in the BIOS
but that's no solution for me because there is no option to disable usb
legacy support and it wouldn't make any sense anyway because the
keyboard is an usb-device, so I really do need support for usb.

Is there a workaround? Is this an already known bug? Anything wrong on
my side?


Thanks,
Thoralf
