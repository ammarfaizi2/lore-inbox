Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268415AbTGOPWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268536AbTGOPO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:14:29 -0400
Received: from mail2.uu.nl ([131.211.16.76]:59338 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S268415AbTGOPFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:05:33 -0400
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: video4linux-list@redhat.com
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030715143119.GB14133@bytesex.org>
References: <20030715143119.GB14133@bytesex.org>
Content-Type: text/plain
Message-Id: <1058282472.2238.75.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jul 2003 17:21:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Gerd,

On Tue, 2003-07-15 at 16:31, Gerd Knorr wrote:
> This patch moves the video4linux subsystem from procfs to sysfs.
[..cool stuff, especially the driver integration fanciness with the
device struct stuff..]
> Comments?

Is /proc going away alltogether?

(I'm not actively following 2.5.x development; I currently can't get any
computer here boot up any recent (>=2.5.72) 2.5 kernel alltogether, see
LKML for details...)

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

