Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSBGJir>; Thu, 7 Feb 2002 04:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSBGJig>; Thu, 7 Feb 2002 04:38:36 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:11943 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286934AbSBGJiU>; Thu, 7 Feb 2002 04:38:20 -0500
Date: Thu, 7 Feb 2002 11:30:49 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide-scsi + sg scatterlist fixup
In-Reply-To: <20020207101624.G16105@suse.de>
Message-ID: <Pine.LNX.4.44.0202071128550.3592-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Jens Axboe wrote:

> Following is a patch to make ide-scsi and sg work again. Of course
> people can just bk pull the latest changes by now...

Would this patch allow the box to recover somewhat after an idiot (namely 
me) does an hdparm -w /dev/hdX on srY?

Regards,
	Zwane Mwaikambo


