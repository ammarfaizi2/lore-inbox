Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUE2H42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUE2H42 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 03:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbUE2H42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 03:56:28 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:20361 "EHLO
	mail6.tpgi.com.au") by vger.kernel.org with ESMTP id S263827AbUE2H41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 03:56:27 -0400
Message-ID: <40B83F15.9070701@linuxmail.org>
Date: Sat, 29 May 2004 17:43:17 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: swsusp-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] suspend2 problems on SMP machine, incorrect tainting
References: <20040528103549.GA2789@elf.ucw.cz>
In-Reply-To: <20040528103549.GA2789@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

I should mention that the code is not perfectly stable at the moment. As soon as it is I'll get 
stuck into last cleanups and then the merge. Crashes I'm seeing involve an oops shortly after 
resuming, occuring in slab code. Obviously an inconsistency has somehow sneaked in. I'm away from 
home for 8 days from Monday AM, so a fix won't be forthcoming this week. It shouldn't be far away 
though.

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

After homosexuality, they'll be arguing paedophilia is normal.
