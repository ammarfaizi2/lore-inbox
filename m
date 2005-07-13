Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVGMTUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVGMTUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVGMTT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:19:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53445 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262715AbVGMTSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:18:36 -0400
Subject: Re: [Hdaps-devel] Re: Updating hard disk firmware & parking hard
	disk
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Paul Slootman <paul+nospam@wurtel.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42D56759.5090301@tmr.com>
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com>
	 <Pine.LNX.4.61.0507131208540.14635@yvahk01.tjqt.qr>
	 <42D4EB21.1060305@grimmer.com>
	 <Pine.LNX.4.61.0507131259480.14635@yvahk01.tjqt.qr>
	 <db33tn$bq5$1@news.cistron.nl>  <42D56759.5090301@tmr.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 15:18:34 -0400
Message-Id: <1121282314.4435.73.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 15:11 -0400, Bill Davidsen wrote:
> Paul Slootman wrote:
> > Jan Engelhardt  <jengelh@linux01.gwdg.de> wrote:
> > 
> >>What's the gain in parking the head manually if it's done anyway when the disk 
> >>spins down (for whatever reason)?
> > 
> > 
> > It seems you're completely missing the whole point of this discussion,
> > which was how to implement the hard disk active protection system that
> > IBM offers under windows for its laptops, that will park the disk when
> > it detects that e.g. the laptop is falling off a table.
> 
> Does that imply that we have software to detect falling off a table?
> 

IBM does, in their Windows driver.

This was all covered in the HDAPS threads of the past few weeks, check
the archives.

Lee

