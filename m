Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132713AbRDCXL1>; Tue, 3 Apr 2001 19:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132715AbRDCXLS>; Tue, 3 Apr 2001 19:11:18 -0400
Received: from p18-max2.adl.ihug.com.au ([203.173.184.210]:42513 "EHLO
	ocdi.sb101.org") by vger.kernel.org with ESMTP id <S132713AbRDCXLG>;
	Tue, 3 Apr 2001 19:11:06 -0400
Date: Wed, 4 Apr 2001 08:39:19 +0930 (CST)
From: Trevor Nichols <ocdi@ocdi.org>
X-X-Sender: <data@ocdi.sb101.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: uninteruptable sleep
In-Reply-To: <3ACA10C7.FB117A53@lexus.com>
Message-ID: <Pine.BSF.4.33.0104040835010.88858-100000@ocdi.sb101.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you compile sysrq into your kernel?

I haven't yet.  I'll enable it and see if I can trigger it next time I
reboot again.


> ps -eo pid,stat,pcpu,nwchan,wchan=WIDE-WCHAN-COLUMN -o args

1230 D     0.0 105cc1 down_write_failed /home/data/mozilla/obj/dist/bin/mozilla-bin


Hopefully that helps a bit more.

-Trev

