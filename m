Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTJaBcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 20:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTJaBcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 20:32:32 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:62129 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S263019AbTJaBcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 20:32:31 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: bd <bdonlan@users.sf.net>, linux-kernel@vger.kernel.org
Subject: Re: Post-halloween doc updates.
Date: Thu, 30 Oct 2003 20:32:26 -0500
User-Agent: KMail/1.5.1
References: <20031030141519.GA10700@redhat.com> <u6f871-68s.ln1@bd-home-comp.no-ip.org>
In-Reply-To: <u6f871-68s.ln1@bd-home-comp.no-ip.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310302032.26773.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.58.154] at Thu, 30 Oct 2003 19:32:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 October 2003 17:16, bd wrote:
>Dave Jones wrote:
>> - The format of /proc/stat changed, which could break some
>>   applications that still depend on the old layout.
>>   Currently the only known application to break is the java
>>   'DOTS' app. (http://bugme.osdl.org/show_bug.cgi?id=277)
>
>'xosview' is also broken by this change.
>
I can confirm this, also xawtv and gnomeradio, neither can apparently 
see the devices registered in at boot time according to grepping 
/var/log/messages.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

