Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUBXUoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUBXUoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:44:04 -0500
Received: from web13706.mail.yahoo.com ([216.136.175.139]:1168 "HELO
	web13706.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262453AbUBXUna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:43:30 -0500
Message-ID: <20040224204329.70893.qmail@web13706.mail.yahoo.com>
Date: Tue, 24 Feb 2004 12:43:29 -0800 (PST)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: libata/iswraid DMA Timeout
To: jabbera@student.umass.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1077654750.403bb4de85d5c@mail-www3.oit.umass.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- jabbera@student.umass.edu wrote:

> Was your fault a random occurance or could you always reproduce it. I
> have only 
> seen mine doing this one particualar operation, and nowhere else, and
> it is 
> perfectly reproducable every time.

Reproducible. Always happened on mount (not on fdisk, not on mke2fs,
I never got to anything beyond mount). I started swapping cables
and thus discovered the faulty cable. Of course, your problem
could be different.

  Martins


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
