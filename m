Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268235AbRG3AVV>; Sun, 29 Jul 2001 20:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268234AbRG3AVM>; Sun, 29 Jul 2001 20:21:12 -0400
Received: from smtp.abac.com ([216.55.128.5]:57863 "EHLO smtp.abac.com")
	by vger.kernel.org with ESMTP id <S268235AbRG3AU5>;
	Sun, 29 Jul 2001 20:20:57 -0400
Date: Sun, 29 Jul 2001 17:22:12 -0700
From: Eugene Kuznetsov <sparky@projectmayo.com>
X-Mailer: The Bat! (v1.47 Halloween Edition)
Reply-To: Eugene Kuznetsov <sparky@projectmayo.com>
X-Priority: 3 (Normal)
Message-ID: <661179265.20010729172212@projectmayo.com>
To: linux-kernel@vger.kernel.org
Subject: USB problem with kernel 2.4.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello everyone,

      I think I'm having a problem ... I've got a computer based on
Intel D815EEA2 motherboard ( Intel 815 chipset ) and an USB mouse.
With kernel 2.4.3 it worked. Today I have upgraded to 2.4.7 and
discovered that attempt to load necessary modules simply locks up the
machine :-/ ... Particularly, issuing 'modprobe uhci' or 'modprobe
usb-uhci' results in complete lock-up. Is this a known problem? I can
give any additional information if needed.

Please cc: me because I am not subscribed to the list.

-- 
Best regards,
 Eugene                          mailto:sparky@projectmayo.com


