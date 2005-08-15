Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbVHOBT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVHOBT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 21:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVHOBT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 21:19:26 -0400
Received: from mail.avantwave.com ([210.17.210.210]:45711 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S932620AbVHOBT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 21:19:26 -0400
Message-ID: <42FFED9C.6080708@avantwave.com>
Date: Mon, 15 Aug 2005 09:19:24 +0800
From: Tomko <tomko@avantwave.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question : any difference between "echo xxx > /dev/console" and printk
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

as topic, do anyone know is there any difference between them ? by the 
way, console should only output but not input , but i could still see 
something when i type " cat /dev/console"  in one terminal then type 
something at the tty where i open the console.  Can anyone tell me why?


Regards,
TOM
