Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTIAVEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTIAVEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:04:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26896
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263276AbTIAVEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:04:20 -0400
Date: Mon, 1 Sep 2003 14:04:29 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unnecessary objects built in 2.6.0-test4?
Message-ID: <20030901210429.GD31760@matchmail.com>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200309010231.39329.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309010231.39329.rob@landley.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 02:31:39AM -0400, Rob Landley wrote:
> I'm running 2.6.0-test4 on my laptop, and it's quite nice.  (Haven't beaten 
> also into submission yet, and it won't suspend, and kde is dropping some 
> events, but everything else is chugging along quite nicely...)
> 
> But the kernel is huge, an I'm curious why.  So I did this in the build 
> directory:
> 

Yes, I have seen this too, but the kernel image size wasn't affected, only
the modules sizes.

I have posted a message on this recently, but nothing came from it... :(

Sorted by date:
7.7M Jul 14 15:03 ../kernel-image-2.6.0-test1_nmf.1_i386.deb
7.7M Jul 16 12:12 ../kernel-image-2.6.0-test1-drv-debug1_nmf.1_i386.deb
6.3M Jul 16 17:19 ../kernel-image-2.6.0-test1-mm1-06int_nmf.1_i386.deb
6.3M Jul 18 17:53 ../kernel-image-2.6.0-test1-mm1-07int_nmf.1_i386.deb
5.5M Jul 21 13:53 ../kernel-image-2.4.22-pre7_nmf.1_i386.deb
6.4M Jul 22 16:29 ../kernel-image-2.6.0-test1-mm2_nmf.1_i386.deb
6.3M Jul 25 11:36 ../kernel-image-2.6.0-test1-g2_nmf.1_i386.deb
6.4M Jul 28 19:00 ../kernel-image-2.6.0-test2-mm1_nmf.1_i386.deb
5.4M Aug  8 14:03 ../kernel-image-2.4.22-rc1_nmf.1_i386.deb
 34M Aug 15 19:17 ../kernel-image-2.6.0-test3-mm2_nmf.1_i386.deb
 34M Aug 24 15:43 ../kernel-image-2.6.0-test3-mm3_nmf.1_i386.deb
 33M Aug 26 19:37 ../kernel-image-2.6.0-test4-mm1_nmf.1_i386.deb
 33M Aug 29 13:54 ../kernel-image-2.6.0-test4-mm3-1-mdfail_nmf.1_i386.deb
 33M Aug 30 19:39 ../kernel-image-2.6.0-test4-mm4_nmf.1_i386.deb
