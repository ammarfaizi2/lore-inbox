Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTDYR60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 13:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbTDYR60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 13:58:26 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:35200 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263580AbTDYR6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 13:58:25 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304251813.h3PIDSug001857@81-2-122-30.bradfords.org.uk>
Subject: Re: versioned filesystems in linux (was Re: kernel support for
To: root@chaos.analogic.com
Date: Fri, 25 Apr 2003 19:13:28 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), msell@ontimesupport.com (Matthew Sell),
       stewartsmith@mac.com (Stewart Smith),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.53.0304251259300.6839@chaos> from "Richard B. Johnson" at Apr 25, 2003 01:06:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Just wondering how difficult it would be to make a 9-track tape drive
> > from scratch, and connect it up to the parallel port...  Do you think
> > that old hard disk motors, from 5.25" MFM disks be powerful enough for
> > the 120IPS tape transport?
> 
> The disk-drive motors, even for the 5.25 floppies were pancake motors
> designed to directly turn the floppy, or run a belt with a small
> ratio. You need a motor that runs at relatively high speed to turn the
> capstan. If the capstan was 1 inch in circumference (about 0.2'' in
> diameter), you need 120 revs/sec = 7200 r.p.m.  You won't do this with
> a floppy motor.

I was thinking of hard disk motors...  Actually, some of those would
be 3600 r.p.m., so if we used a large capstan, we might be in with a
chance :-).  (You'd really need to drive the actual reels as well,
though, I can't see us starting and stopping the whole thing very
quickly just using the capstan motor.)

John.
