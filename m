Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVCWNpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVCWNpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVCWNpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:45:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45006 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262304AbVCWNmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:42:18 -0500
Date: Wed, 23 Mar 2005 14:42:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-os <linux-os@analogic.com>
cc: linux lover <linux_lover2004@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Accessing data structure from kernel space
In-Reply-To: <Pine.LNX.4.61.0503230823420.14182@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0503231441000.10048@yvahk01.tjqt.qr>
References: <20050323132036.99757.qmail@web52202.mail.yahoo.com>
 <Pine.LNX.4.61.0503230823420.14182@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hello all,
>>       I have one linked list data structure added to
>> a file in kernel source code which has some kernel
>> info. I want to acess that linked list structure from
>> user space. Is that possible??

Yes!!

>>       Also how to add own system call usable at user
>> level from kernel module??

!!

> Many people will tell you to use the /proc file-system.

*cough* sysfs *cough*
err...(due to new horizons):
*cough* relayfs *cough*



Jan Engelhardt
-- 
