Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUDXT5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUDXT5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 15:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDXT5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 15:57:16 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:42374 "EHLO
	mail-relay-2.tiscali.i") by vger.kernel.org with ESMTP
	id S261756AbUDXT5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 15:57:12 -0400
Date: Sat, 24 Apr 2004 21:47:27 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Unable to read UDF fs on a DVD
Message-ID: <20040424194727.GA3353@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040423195004.GA1885@dreamland.darkstar.lan> <1082751675.3163.106.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082751675.3163.106.camel@patibmrh9>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, Apr 23, 2004 at 02:21:15PM -0600, Pat LaVarre ha scritto: 
> P.S. Five postscripts:
> 
> 1)
> 
> > even with ide-scsi, though.
> 
> Whoa.  You weren't engaging in the taboo act of running ide-scsi in 2.6
> back when ls failed, were you?

No, I wasn't. I'm aware that ide-scsi is not needed with 2.6. I had to
recompile the kernel with ide-scsi to make Philips fsck happy.

> 3)
> 
> I can't now rapidly reproduce the collection of file lengths you report,
> because sparse files in UDF, even when the underlying volume is not
> sparse, as yet crash my Linux-2.6.5.

Well, Ben Fennema said that he has identified the issue. If it can be
usefull I can have my friend burn another DVD (with less data) with Easy
CD and upload the image somewhere.

> 5)
> 
> > http://web.tiscali.it/kronoz/ucf_test.log
> 
> Any chance this link will still work, a year from now?

Yup, no problem.

Luca
-- 
Home: http://kronoz.cjb.net
Alcuni pensano che io sia una persona orribile, ma non e` vero. Ho il
cuore di un ragazzino - in un vaso sulla scrivania.
