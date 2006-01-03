Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWACTfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWACTfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWACTfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:35:06 -0500
Received: from xenotime.net ([66.160.160.81]:23218 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932454AbWACTfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:35:04 -0500
Date: Tue, 3 Jan 2006 11:35:03 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year, libata hackers
In-Reply-To: <43BAB977.3010203@pobox.com>
Message-ID: <Pine.LNX.4.58.0601031132230.16308@shark.he.net>
References: <43BAB977.3010203@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Jeff Garzik wrote:

>
> Well, another year has passed, and somehow the duct tape that keeps our
> hard drives together has remained intact.  After a nice and refreshing
> holiday, I have a bunch of patches pending, that will probably take a
> week or two to sort through.
>
> For 2.6.16, my main goals are getting irq-pio upstream and supporting
> iomap -- which will kill all those annoying warnings finally.  And
> probably some EH work from Tejun will go in too.  The suspend/resume
> stuff is shaping up nicely, and device hotplug work suddenly reappeared.
>   Fun for all.

+ selectable debugging macros etc.
  (used in ACPI suspend/resume patches, but can be used in all of libata)

> Port multiplier and NCQ (queueing) support are the two other big to-do
> items on the list.
>
> I updated the hardware status report at
> 	http://linux.yyz.us/sata/
>
> and will update the software status report in a week or two.
>
> Everybody wants to play in the same sandbox, so please be patient as we
> sort it all out.
>
> Cheers and happy new year,

Likewise.

-- 
~Randy
