Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUCYDsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUCYDsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:48:21 -0500
Received: from mx15.sac.fedex.com ([199.81.195.17]:27146 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S263137AbUCYDsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:48:20 -0500
Date: Thu, 25 Mar 2004 11:48:35 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
In-Reply-To: <20040324235702.GA497@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0403251147430.999@boston.corp.fedex.com>
References: <20040324235702.GA497@elf.ucw.cz>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/25/2004
 11:48:14 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/25/2004
 11:48:17 AM,
	Serialize complete at 03/25/2004 11:48:17 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Mar 2004, Pavel Machek wrote:

> If you have machine with >=1GB of RAM, do you think you could test
> this patch? [I'd like to hear about successes, too; perhaps send it
> privately].

It works! 1GB of RAM. Highmem enabled.


Thanks,
Jeff

