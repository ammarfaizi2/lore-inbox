Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVDILQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVDILQI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 07:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDILQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 07:16:08 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:56589 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261333AbVDILQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 07:16:05 -0400
Date: Sat, 9 Apr 2005 13:16:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C rtc8564.c remove duplicate include (fixed)
Message-Id: <20050409131643.4269911a.khali@linux-fr.org>
In-Reply-To: <425125EC.6080201@anagramm.de>
References: <425125EC.6080201@anagramm.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clemens,

> [PATCH] I2C rtc8564.c remove duplicate include
> 
> Trivial fix: removes duplicate include line.
> 
> Patch applies to: 2.6.11.x
> 
> (This is my very first patch to the linux-kernel, so let me
> start with small things first...)
> 
> Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>

There's nothing wrong with small things like that, but unfortunately
your patch is somehow malformed and won't apply. Maybe your e-mail
client broke it. Still I am interested in this clean up patch, so I
would appreciate if you could check what went wrong, fix it and send a
working patch.

Thanks,
-- 
Jean Delvare
