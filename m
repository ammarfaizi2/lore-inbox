Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWDAUGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWDAUGw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 15:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWDAUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 15:06:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:49322 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751620AbWDAUGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 15:06:52 -0500
Date: Sat, 1 Apr 2006 22:06:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Unimplemented system call" wrong?
In-Reply-To: <jemzf66c2h.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0604012206330.18122@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603311340040.18342@yvahk01.tjqt.qr>
 <jemzf66c2h.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I seriously doubt that put_user() can return -ENOSYS
>
>put_user can only return -EFAULT or 0.
>
But what may be causing ENOSYS then?


Jan Engelhardt
-- 
