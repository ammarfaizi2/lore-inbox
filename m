Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbTDLClV (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 22:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbTDLClV (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 22:41:21 -0400
Received: from [12.47.58.73] ([12.47.58.73]:19224 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263111AbTDLClV (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 22:41:21 -0400
Date: Fri, 11 Apr 2003 19:53:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-Id: <20030411195308.11812ee9.akpm@digeo.com>
In-Reply-To: <20030412023848.GB650@zip.com.au>
References: <20030401100237.GA459@zip.com.au>
	<20030401022844.2dee1fe8.akpm@digeo.com>
	<20030412021638.GA650@zip.com.au>
	<20030411192413.279f0574.akpm@digeo.com>
	<20030412023848.GB650@zip.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2003 02:52:58.0416 (UTC) FILETIME=[9FE89B00:01C3009E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
>
> > How many files are on the filesystem?
> 
> 197MB: 2728 files
> 1.2GB: 53707 files
> 
> > How much physical memory does the machine have?
> 
> 256MB

scrub that theory then.

