Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUAaIQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 03:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUAaIQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 03:16:50 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:51436 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264132AbUAaIQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 03:16:49 -0500
Date: Sat, 31 Jan 2004 21:18:14 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
In-reply-to: <200401310809.46256.luke7jr@yahoo.com>
To: Luke-Jr <luke7jr@yahoo.com>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1075537093.18161.83.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1075436665.2086.3.camel@laptop-linux>
 <200401310722.51472.luke7jr@yahoo.com>
 <1075534274.17730.65.camel@laptop-linux> <200401310809.46256.luke7jr@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.

If linux/suspend.h is missing, you probably didn't apply the core patch.

Regards,

Nigel

On Sat, 2004-01-31 at 21:09, Luke-Jr wrote:
> init/do_mounts.c:6:27: linux/suspend.h: No such file or directory

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

