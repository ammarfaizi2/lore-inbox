Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132122AbRCYRNu>; Sun, 25 Mar 2001 12:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbRCYRNk>; Sun, 25 Mar 2001 12:13:40 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15075 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132122AbRCYRNV>;
	Sun, 25 Mar 2001 12:13:21 -0500
Message-ID: <3ABE2708.E9422DD8@mandrakesoft.com>
Date: Sun, 25 Mar 2001 12:12:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michel Wilson <michel@procyon14.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <NEBBLEJBILPLHPBNEEHIEEPNCAAA.michel@procyon14.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Wilson wrote:
> Ever thought about how you would kill a process: kill -9 127892752 doesn't
> sound very appealing to me.

man killall(1).  Kill processes by name.

> So you'd also need to implement a mechanism that allows for 'easy' selection
> of processes to kill, for example giving every process with the same name
> a unique identifier (like httpd_0, httpd_1, httpd_2 and so on).

huh?

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
