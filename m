Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTLAIr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 03:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTLAIr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 03:47:29 -0500
Received: from mail2.btignite.se ([194.213.69.45]:18438 "HELO
	mail2.btignite.se") by vger.kernel.org with SMTP id S262109AbTLAIr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 03:47:28 -0500
Message-ID: <3FCB001C.7000705@lanil.mine.nu>
Date: Mon, 01 Dec 2003 09:47:24 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031117 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: USB mass-storage hell
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this USB harddrive and a USB mp3-player, when I plug them in 
would like them to be mounted at /mnt/hd and /mnt/mp3 by auto.
Is this possible using 2.6 and some supermount-like daemon?

Also, the device I plugin first becomes /dev/sda1 and the second 
/dev/sda2 (using devfs) so I cant rely upon device names here to do 
anything. Is there any ID of the USB-device aviable somewhere that can 
be of any use?

-- 
Christan Axelsson
smiler@lanil.mine.nu


