Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWJOPFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWJOPFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 11:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWJOPFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 11:05:09 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:7431 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750844AbWJOPFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 11:05:08 -0400
Date: Sun, 15 Oct 2006 17:05:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: feature-removal-schedule obsoletes
Message-Id: <20061015170503.e91b6f76.khali@linux-fr.org>
In-Reply-To: <45324658.1000203@gmail.com>
References: <45324658.1000203@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sun, 15 Oct 2006 16:31:29 +0159, Jiri Slaby wrote:
> I figured out these requests for removal with past dates. What's the state of
> them now, could you reschedule or delete (or just confirm here to post one patch
> correcting this file)?
> 
> [Why:s were removed in this mail]
> (...)
> ---------------------------
> 
> What:   i2c-ite and i2c-algo-ite drivers
> When:   September 2006
> Who:    Jean Delvare <khali@linux-fr.org>
> 
> ---------------------------

The patch is ready, it's in my local stack:
http://khali.linux-fr.org/devel/linux-2.6/i2c-delete-ite-bus-driver.patch

I'll push it upstream soon.

Thanks,
-- 
Jean Delvare
