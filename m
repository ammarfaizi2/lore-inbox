Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUAPENz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 23:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUAPENz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 23:13:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:39063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263462AbUAPENy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 23:13:54 -0500
Date: Thu, 15 Jan 2004 20:13:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs class support for vc devices [10/10]
Message-Id: <20040115201358.75ffc660.akpm@osdl.org>
In-Reply-To: <20040115204356.GK22199@kroah.com>
References: <20040115204048.GA22199@kroah.com>
	<20040115204111.GB22199@kroah.com>
	<20040115204125.GC22199@kroah.com>
	<20040115204138.GD22199@kroah.com>
	<20040115204153.GE22199@kroah.com>
	<20040115204209.GF22199@kroah.com>
	<20040115204241.GG22199@kroah.com>
	<20040115204259.GH22199@kroah.com>
	<20040115204311.GI22199@kroah.com>
	<20040115204329.GJ22199@kroah.com>
	<20040115204356.GK22199@kroah.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> This patch add sysfs support for vc char devices.
> 
>  Note, Andrew Morton has reported some very strange oopses with this
>  patch, that I can not reproduce at all.  If anyone else also has
>  problems with this patch, please let me know.

It seems to have magically healed itself :(

Several people were hitting it.  We shall see.
