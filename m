Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUHOGNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUHOGNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 02:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266507AbUHOGNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 02:13:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:59042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266498AbUHOGNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 02:13:36 -0400
Date: Sat, 14 Aug 2004 23:11:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: dsaxena@plexity.net, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-Id: <20040814231153.24a4f8e7.akpm@osdl.org>
In-Reply-To: <20040811235929.GB32468@redhat.com>
References: <20040811224117.GA6450@plexity.net>
	<20040811231314.GA32106@redhat.com>
	<20040811234245.GA7721@plexity.net>
	<20040811235929.GB32468@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
>  > My understanding is that goal is to 
>   > make /proc slowly return to it's original purpose (process-information) 
>   > and move other data out into sysfs.  
> 
>  I don't think thats a realistic goal.

It may be realistic if we try hard enough, but I don't think it's a
desirable one at this time.  I'd prefer that I, Deepak and everyone else be
spending cycles on higher-priority things than these patches.  Sorry.


