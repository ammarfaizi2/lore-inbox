Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVFUGhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVFUGhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVFUGcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:32:17 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:49072 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262041AbVFUGbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:31:45 -0400
Date: Mon, 20 Jun 2005 23:31:15 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Greg KH <gregkh@suse.de>
cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
In-Reply-To: <20050621062843.GA15062@kroah.com>
Message-ID: <Pine.LNX.4.62.0506202330020.14659@qynat.qvtvafvgr.pbz>
References: <200506181332.25287.nick@linicks.net> <200506202000.08114.nick@linicks.net>
 <20050620192118.GA13586@suse.de> <200506202032.30771.nick@linicks.net>
 <Pine.LNX.4.62.0506201242100.13723@qynat.qvtvafvgr.pbz> <20050621062843.GA15062@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll check tomorrow, I was useing what was on the FC3 iso images, it would 
eventually boot, but it would hang on udev with a 2.6.11.x or 2.6.12-pre6 
kernel for 2-3 min before continueing through the boot.

David Lang

  On Mon, 20 Jun 
2005, Greg KH wrote:

> Date: Mon, 20 Jun 2005 23:28:43 -0700
> From: Greg KH <gregkh@suse.de>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12 udev hangs at boot
> 
> On Mon, Jun 20, 2005 at 12:42:39PM -0700, David Lang wrote:
>> I ran into the same issue last week on fedora core 3 so it's not _just_ a
>> slackware problem.
>
> FC 3, with default udev install will not boot with 2.6.12?  What version
> of udev is the latest for FC3?
>
> thanks,
>
> greg k-h
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
