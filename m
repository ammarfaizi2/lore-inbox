Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSFXBs1>; Sun, 23 Jun 2002 21:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSFXBs0>; Sun, 23 Jun 2002 21:48:26 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:17119 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317219AbSFXBsZ>; Sun, 23 Jun 2002 21:48:25 -0400
Date: Sun, 23 Jun 2002 18:50:28 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] /proc/scsi/map
To: Nick Bellinger <nickb@attheoffice.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Message-id: <3D167AE4.1080409@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3D14B2CF.90002@pacbell.net> <1024769900.6875.139.camel@subjeKt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This reiterates the need for a sound logical device naming scheme that
> fits into driverfs without mucking up the basic structure.  Not being a
> expert on naming, the least offensive format I can think with regard to
> iSCSI would be something along the lines of:
>   
> $DRIVERFS/virt/iscsi/iqn.2002-06.com.foo.super.turbo.disk.array.3543/disk0

That could do the job, but I'll leave those discussions up to SCSI
experts ... seems there are folk there who know something about the
topic, unlike me !  :)

Perhaps such things will be discussed at OLS next week, not that
I'll be there.

- Dave


