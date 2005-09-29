Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVI2VsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVI2VsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVI2VsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:48:08 -0400
Received: from xenotime.net ([66.160.160.81]:60891 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030262AbVI2VsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:48:06 -0400
Date: Thu, 29 Sep 2005 14:48:06 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, axboe@suse.de, torvalds@osdl.org
Subject: Re: SATA suspend/resume (was Re: [PATCH] updated version of Jens'
 SATA suspend-to-ram patch)
In-Reply-To: <Pine.LNX.4.58.0509291309050.1424@shark.he.net>
Message-ID: <Pine.LNX.4.58.0509291446430.1424@shark.he.net>
References: <20050923163334.GA13567@triplehelix.org> <433B79D8.9080305@pobox.com>
 <Pine.LNX.4.58.0509291309050.1424@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Randy.Dunlap wrote:

> Here's Nathan Bryant's patch (from the lwn.ne article) updated
> to 2.6.14-rc2-git7 + changes that Christoph suggested (except
> that 'scsi_device_resume' name was already used, so I changed it
> to 'scsi_device_wakeup' instead).
>
> I'll get back to Jeff's suggestion(s) and the sysfs flag next,
> but others can use this as a basis if wanted.
>
> (also available from
> http://www.xenotime.net/linux/scsi/scsi-suspend-resume.patch
> )

The inline version of this patch is whitespace-damaged  :(
(thanx to pine).

It's ok for review, but please download the one above
for applying or patching.

-- 
~Randy
