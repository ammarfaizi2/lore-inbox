Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbTDGNEt (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTDGNEt (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:04:49 -0400
Received: from wotug.org ([194.106.52.201]:50043 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id S263403AbTDGNEs (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 09:04:48 -0400
Message-Id: <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 07 Apr 2003 14:16:23 +0100
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: Problems booting PDC20276 with new IDE setup code.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E90E3C5.80109@gmx.net>
References: <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
 <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:34 07/04/2003, Carl-Daniel Hailfinger wrote:
>Could you please try 2.4.21-pre7 (this has another batch of IDE updates) 
>and enable the option
>"Special FastTrak Feature"?
>In your .config, the option would be
>CONFIG_PDC202XX_FORCE=y
>and report back to the list?


For reasons reported in another mail (ac97 fails to build) my attempt at 
pre7 failed. Also, as far as I know, the FastTrak feature enables the 
Promise RAID mode: I am not using that. Instead, I just want 4 IDE disks 
which will be bound using Linux raid5.

Are you saying you want to know if the Promise mode works (independent of 
whether I wish to use it?)

Ruth 

